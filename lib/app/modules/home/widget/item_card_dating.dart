import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvit_dating_app/app/core/utils/util.dart';
import 'package:luvit_dating_app/app/core/values/text_styles.dart';
import 'package:luvit_dating_app/app/core/widget/ripple.dart';
import 'package:luvit_dating_app/app/data/model/user_dating.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/values/app_values.dart';
import '../../../core/widget/asset_image_view.dart';

class ItemCardDating extends StatefulWidget {
  const ItemCardDating({
    Key? key,
    required this.item, this.height, this.width,
    this.showDelete = false,
    this.index = -1,
    this.onSelectedIndex,
  }) : super(key: key);

  final UserDating item;
  final double? height;
  final double? width;
  final bool showDelete;
  final int index;
  final ValueChanged<int>? onSelectedIndex;

  @override
  State<ItemCardDating> createState() => _ItemCardDatingState();
}

class _ItemCardDatingState extends State<ItemCardDating> {
  int index = 0;

  _updateIndex(int val){
    if(widget.onSelectedIndex != null) widget.onSelectedIndex!(val);
    setState(() {
      index = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.index != -1) index = widget.index;

    return Container(
      height: widget.height,
      width: widget.width,
      margin: const EdgeInsets.symmetric(horizontal: AppValues.margin_2),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.transparent,
        border: Border.all(color: AppColors.colorBorderGrey, width: 2)
      ),
      child: Stack(
        children: [

          CachedNetworkImage(imageUrl: widget.item.images?[index]??'',
            width: double.infinity, height: double.infinity, fit: BoxFit.cover,
            imageBuilder: (ctx, image) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: boxDecorationWithRoundedCorners(
                    borderRadius: radius(AppValues.radius),
                    border: Border.all(color: AppColors.colorBorderGrey, width: 2),
                    decorationImage: DecorationImage(image: CachedNetworkImageProvider(widget.item.images![index]), fit: BoxFit.cover)
                ),
              );
            },
            placeholder: (ctx, val) => const Text('luvit', style: cardTitleStyle,).center(),
            errorWidget: (ctx, err, val){
              return Text('${val.message}', style: cardTitleStyle, maxLines: 2, textAlign: TextAlign.center,).center();
            },
          ).withShaderMaskGradient(cardGradient),

          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppValues.smallPadding.toInt().height,

              widget.item.images == null ? Container() :
              Row(
                children: widget.item.images?.map((e) => itemImagesHint(isSelected: e == widget.item.images![index])).toList() ?? [],
              ).marginSymmetric(horizontal: AppValues.padding),

              Row(
                children: [
                  Ripple(onTap: (){
                    var val = index;
                    if(index==0) return;
                    _updateIndex(val-1);
                  }).expand(),
                  Ripple(onTap: (){
                    var val = index;
                    if(index+1 == widget.item.images?.length) return;
                    _updateIndex(val+1);
                  }).expand(),
                ],
              ).expand(),

              Row(
                children: [
                  index == 0 ? info1().expand() :
                  index == 1 ? info2().expand() :
                  info3().expand(),

                  widget.showDelete
                      ? const CircleAvatar(child: Icon(Icons.delete))
                      : const AssetImageView(fileName: 'ic_like.png',)
                ],
              ).marginSymmetric(horizontal: AppValues.padding),

              const Icon(Icons.expand_more_rounded, color: Colors.white,),

              AppValues.padding.toInt().height,

            ],
          ),
        ],
      ),
    );
  }

  Widget itemImagesHint({bool? isSelected = false}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppValues.padding_2),
      height: 3,
      decoration: boxDecorationWithRoundedCorners(
          backgroundColor: isSelected == true ? AppColors.colorSecondary : AppColors.colorPrimary
      ),
    ).expand();
  }

  Widget info1(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        likeWidget(),
        titleAge(),
        Text('${widget.item.location} - 2km away', style: whiteText14,),

      ],
    );
  }

  Widget info2(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        likeWidget(),
        titleAge(),
        Text('${widget.item.description}', style: whiteText14,),
      ],
    );
  }

  Widget info3(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        likeWidget(),
        titleAge(),
        AppValues.smallPadding.toInt().height,
        Wrap(
          runSpacing: AppValues.smallPadding,
          spacing: AppValues.smallPadding,
          children: widget.item.tags!.map((tag) => tagItem(tag)).toList(),
        )
      ],
    );
  }

  Widget tagItem(String tag){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.padding, vertical: AppValues.extraSmallPadding),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(AppValues.radius),
        backgroundColor: AppColors.colorPrimary
      ),
      child: Text(tag, style: whiteText16,),
    );
  }

  Widget likeWidget(){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.smallPadding, vertical: AppValues.padding_4),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.colorBorderGrey),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppValues.radius),
                  right: Radius.circular(AppValues.radius)
              ),
            color: Colors.black
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AssetImageView(fileName: 'ic_star.png', color: AppColors.textColorGreyDark,),
              AppValues.smallPadding.toInt().width,
              Text(widget.item.likeCount.toCommaSeparated, style: whiteText13,)
            ],
          ),
        ),

        Container().expand()
      ],
    );
  }

  Widget titleAge(){
    return Row(
      children: [
        Text(widget.item.name ?? '', style: whiteText32.copyWith(fontWeight: FontWeight.w600),),
        AppValues.smallPadding.toInt().width,
        Text('${widget.item.age}', style: whiteText32,)
      ],
    );
  }
}

