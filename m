Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388898AbeHPJNp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2018 05:13:45 -0400
Date: Thu, 16 Aug 2018 11:47:30 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: chemical: bme680: change MSK->MASK in
 #defines
Message-ID: <20180816061730.GA1916@himanshu-Vostro-3559>
References: <20180815203835.21079-1-dpfrey@gmail.com>
 <20180815203835.21079-5-dpfrey@gmail.com>
 <ac666b9e-0767-fa08-58e6-2ea9cd3c7f91@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ac666b9e-0767-fa08-58e6-2ea9cd3c7f91@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 15, 2018 at 02:03:31PM -0700, David Frey wrote:
> On 8/15/2018 1:38 PM, David Frey wrote:
> 
> <snip>
> 
> > diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> > index 49bb6b84f181..d62cb88af481 100644
> > --- a/drivers/iio/chemical/bme680_core.c
> > +++ b/drivers/iio/chemical/bme680_core.c
> 
> When splitting the patches apart, I screwed this one up slightly.  The patch
> should also include this hunk:
> 
> > @@ -206,7 +206,7 @@ static int bme680_read_calib(struct bme680_data *data,
> >                 return ret;
> >         }
> >         calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> > -                       (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> > +                       (tmp_lsb & BME680_BIT_H1_DATA_MASK);
> > 
> >         ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
> >         if (ret < 0) {
> 
> What is the correct course of action in the situation?  Should I resend just
> this one patch immediately?  Would it get a new version number "[PATCH v3
> 4/7]"?  I think the version number refers to the whole patch series, so it
> seems wrong to bump the revision of one patch and not transmit the whole
> series.

The rule is send the whole series again with the changelog mentioned
below the '---' and in your case mentioning
"no changes in this patch" in the changelog for all other patches in
series would be nice.

Another issue which I see is that you would need to rebase on top of my
patch that I sent a while ago because otherwise the patch won't apply
cleanly to the iio tree.

https://lore.kernel.org/lkml/20180811102636.6171-1-himanshujha199640@gmail.com/t/#u

As soon as you would next version, I would get it tested.

Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
