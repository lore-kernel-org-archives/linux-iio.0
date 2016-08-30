Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36250 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750697AbcH3IDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 30 Aug 2016 04:03:23 -0400
Received: by mail-oi0-f42.google.com with SMTP id f189so15723948oig.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Aug 2016 01:03:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <EE9C959F078FB848A746007A912E497B024A2E74C1@SAFEX1MAIL3.st.com>
References: <1472163008-9516-1-git-send-email-linus.walleij@linaro.org>
 <a822abf1-03f5-fa06-9843-c02c77c09acc@kernel.org> <EE9C959F078FB848A746007A912E497B024A2E74C1@SAFEX1MAIL3.st.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 30 Aug 2016 10:03:22 +0200
Message-ID: <CACRpkdYc4n=Fq-o1vS9J53JRLWu81==Rk_=cRR1_OMfg6=XfpQ@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: fetch and enable regulators unconditionally
To: Giuseppe BARBA <giuseppe.barba@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Denis CIOCCA <denis.ciocca@st.com>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 30, 2016 at 9:21 AM, Giuseppe BARBA <giuseppe.barba@st.com> wrote:

>> > +   pdata->vdd_io = devm_regulator_get(indio_dev->dev.parent,
>> "vddio");
>> > +   if (IS_ERR(pdata->vdd)) {
> I think this check is not correct: you have to check the pdata->vdd_io and not
> the pdata->vdd (that is already checked before).
>
>> > +           dev_err(&indio_dev->dev, "unable to get Vdd_IO
>> supply\n");
>> > +           err = PTR_ERR(pdata->vdd);
> And here you should use the pdata->vdd_io.

Ah, of course, and I've even done that mistake before :(

I'll send a follow-up patch to fix the fix.

Yours,
Linus Walleij
