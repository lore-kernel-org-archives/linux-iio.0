Return-Path: <SRS0=Wwjn=OY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37306C43387
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E23206C2
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 19:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU7vZ7HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbeLOTRv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:17:51 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42054 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLOTRv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Dec 2018 14:17:51 -0500
Received: by mail-pl1-f179.google.com with SMTP id y1so4237495plp.9
        for <linux-iio@vger.kernel.org>; Sat, 15 Dec 2018 11:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQz+IRc8jBo5vkepfo++dNRe/X9/sCTTYNAQjyHcv0E=;
        b=nU7vZ7HCwv1JtofEdJcGdRza8vLCGuBALhEYEkTePFRylgTwrZSWEVb4+4SIZwXlCe
         OS1LgRveCLVJCwW6mAglNQruKOXhzOSvSzPXZ6x1uuUS0BGCZoaoVajALNN21pSWWii8
         4W8l4lJJMatcrJAQnSR2McBf6gmk1kiVs/NB3JHw7pQhw7OtpvoKg+O7TAzndC+Y1qIf
         /JU1PQHl4WhMo3e34ucGIc+d8p08m5k8zlUdVt0LsX1kCJqUMmh0IPO7Qr+9kspIV3Vl
         Ydj7BRRrTDSQaYFl8dF0Jl+nDmpSB18KHOAEhyC19sX/G/G6ZuwhB5x1I3g0j1Nvpq0j
         1jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQz+IRc8jBo5vkepfo++dNRe/X9/sCTTYNAQjyHcv0E=;
        b=Kt6SNqyG7buhidqmUcnMs8n3WoKTyDxBvCDcYduYFgUW8GN+PbO7pzn7EHFrUwZ1LQ
         fTK0YqstKfdMURDvgZqcSeTEfRSZdlYmUBzT5RqJVx5F6q8DG+S+HFUtblifhh+WZSLS
         juoGXtheqqYPCloskd1wnS4n1DamWMm0zZljNLiRdwo894086xGYf3pPsDsG+r1KDfhC
         Pg8rVTOfLhGy8GElPymEailZYWrDhRM7AZQL7tt2bc72O8Y5iNUgzfjj9c8FaYxcIK4d
         EF/oQpw6x+msZMtngavxaOEbD6MgfpzB2H8C9iXOc4Grp2FrMnypsjYDPcrExgmRWRUA
         vGwg==
X-Gm-Message-State: AA+aEWac4bkq4Pv6bebpq2bWyC3ip7UvNktkpmNzCw8J9cMBMR83m2gX
        Fltm6R4Buam3B+pFgqEBSU8=
X-Google-Smtp-Source: AFSGD/Vl+0WdhXaTP4dGL6DFnwQu5B3G0Kro8XUQHT1g2ya24bz7fbKu1GZWc5clmN8l12nTVasvGw==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr7269130plx.231.1544901469266;
        Sat, 15 Dec 2018 11:17:49 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id b68sm14417938pfg.160.2018.12.15.11.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Dec 2018 11:17:48 -0800 (PST)
Date:   Sun, 16 Dec 2018 00:47:43 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Tuukka Pasanen <pasanen.tuukka@gmail.com>
Cc:     linux-iio@vger.kernel.org, dpfrey@gmail.com
Subject: Re: IIO BME680 driver
Message-ID: <20181215191743.GA1263@himanshu-Vostro-3559>
References: <712905bc-4d81-0b38-44d6-d4f31f08c3ae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712905bc-4d81-0b38-44d6-d4f31f08c3ae@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

+Cc linux-iio & David Frey

Hi Tuukka,

On Fri, Dec 14, 2018 at 09:49:06AM +0200, Tuukka Pasanen wrote:
> Hello,
> 
> I've been testing BME680 i2c IIO driver and it works as expected (actually
> I'm very happy with it). Before that I was using BME680 lib from Pimoroni
> and only thing I'm missing is that there is user defined prefix to fix
> incorrect values that are hard coded in ROM (Can be found here):
> 
> https://github.com/pimoroni/bme680-python/blob/e827e5d622fd70df2aee6a68ebac626cf539ee55/library/bme680/__init__.py#L89

Hmm. Why would anyone want to play with those calibration constants
programmed into the NVM of the sensor.

And I wonder how the following came up ?
https://github.com/pimoroni/bme680-python/blob/e827e5d622fd70df2aee6a68ebac626cf539ee55/library/bme680/__init__.py#L331

These algorithms are provided by Bosch and probably should be used as-is
unless you got some information from them. But I don't see any such
reference in the datasheet nor in their API.

Or it might be some heuristics. Not sure about it!

> This one adjust temperature every time one reads it. For example my room
> temperature is something like 21C (I live in north) and BME680 reports 28C
> so humidity and pressure are incorrect (not much but notable).

Now since you're using IIO driver, I see the problem here:
https://github.com/torvalds/linux/blob/master/drivers/iio/chemical/bme680.h#L52

	#define BME680_AMB_TEMP				25

Yes, it is hardcoded here and you should change it to according to your
room temperature(20-21 degC).


I really like the approach of *not* harcoding the ambient temperature
and instead using the temperature sensor readout as a substitute to the
ambient temp as evident in the python api above.

But the problem lies in the organisation of IIO driver of isolating
different channels. What I simply mean is, what if I only run
gas part without any temperature sensing part ? How would you get the
ambient temperature in the case ? In such a case, we need throw a dummy
temp read in the relevant readout functions and store them in the
private struct. But then following this approach is wastage of power
and increases latency in the readings.

David had earlier pointed out if we are already wasting resources by
doing the same thing each time for each of the readings which can be
accomplished in a single readout i.e., triggering forced mode does a
single TPHG cycle and after we can read all the data. But currently we
set it each time for each of temp, press, humid and gas reading.

And only advantage I see with the current implementation is you can read
a single channel value if you want without disturbing other channels
which you can't in that python implementation.

There are two things that I shall be soon working on as soon as my
current work with Zephyr ends:

1. add profile duration function
2. check for new available data before fetching
 ... and more if anything comes up.

Anyway, Bosch ported BME680 to The Zephyr Project and I reviewed+tested
the driver on nRF52840 development board. Works great!
Though the maintainers didn't merge the PR due to lack of
those compensation algorithms in the datasheet *chuckle*

At least Jonathan(IIO maintainer) merged with a note in the commit log ;)

Bosch claimed that new datasheet shall be soon be available with all the
missing info, and then anyone wouldn't need to reverse engineer their API
or BSEC to get the desired info :P


Thank you for using the IIO driver and I'm glad that there are users out
there testing it. Please let me know if there are any more issues :)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
