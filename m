Return-Path: <SRS0=KJmS=QT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3FAC282C4
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6292C217D9
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="piFK616k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfBLQxv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:53:51 -0500
Received: from mail-pf1-f176.google.com ([209.85.210.176]:40761 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729371AbfBLQxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Feb 2019 11:53:50 -0500
Received: by mail-pf1-f176.google.com with SMTP id h1so1559100pfo.7
        for <linux-iio@vger.kernel.org>; Tue, 12 Feb 2019 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=2lxS60/Qs9VofHxZyeQxlwtSpqIsW8WB6B9WgoAemNU=;
        b=piFK616kAqHPy1jXTDfgV6DxMNfmGMh8g1ETozgNxVw0CO5K1syulYKbJXk38kOCW2
         yflxQdf518r9BvhHhm4ij19lBvzqkLn0uoiYnj4WLkvg5C3/HLBnEe9z1PCUM+8VEnzA
         mTfGBJAsISUvXWCBKuQqslQ1ts922B+7a5AyQ722F4+G8GTjehyMlc8UpyHIY8wJAYM+
         d46hpLDbzEWU3vUcxAWM5eTlydea6CLmBwaBl+o55Q9L7sFz6QDalDA1wn+jeIYe27d/
         qhEuQr2/AmN/EB//EV6mNLcuJxmBZuoAL5vDMWT8bAfo9kaT5LqaAoDXS2c1CFW7zdMm
         1MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=2lxS60/Qs9VofHxZyeQxlwtSpqIsW8WB6B9WgoAemNU=;
        b=jTGl19/6TtiduG+YO/Y7wlXD2yNDekaJjMmuytbPOjDSjd6zezYOeO0lhk/QbdayBL
         ba3zAWW1qCRGBTTTOIBKkshXv+UT2uYti5hLAB9/Q5V54Q191cDc4QU/PGRHek4dUBeC
         je4Du+mCmuUkpEbGwFNyBTjQQzawnhvrBdcDP6GST1Izgt9F0EQLUo4z9E3gzB+dLk56
         320KeKj4ZG857S83tJQE6IQuMN8Ic2uLLIewRjMUW0AdZsvSjZyc7F5HG9IX9UzAx9LX
         pX+HZ+YJCjZLC7TzlR7KcMXj19j74nT6o807Cw/40oHCTwc1sBdoYzrT6wz9L5r0y5js
         MHcQ==
X-Gm-Message-State: AHQUAubVnJeTRJtPBUPvUpEpAMw3MzVeWjzWzkv/W6wQVuF+GxxkUs95
        vc3pep/ueBvb8jhc/SBol7to9ilq
X-Google-Smtp-Source: AHgI3Ia7mPAQbwbw6D5O0mZ7SSeGu6BkOCSLJ58Z0TAdvUZqw8t12ALZ6gHcfdOcbXWz3s01YzV3qw==
X-Received: by 2002:a63:f74f:: with SMTP id f15mr4515250pgk.190.1549990429249;
        Tue, 12 Feb 2019 08:53:49 -0800 (PST)
Received: from [192.168.1.8] ([172.103.152.101])
        by smtp.gmail.com with ESMTPSA id 125sm20317043pfx.159.2019.02.12.08.53.47
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:53:48 -0800 (PST)
To:     linux-iio <linux-iio@vger.kernel.org>
From:   David Frey <dpfrey@gmail.com>
Subject: bme680 gas sensor channel attributes
Message-ID: <c8ffa8de-ecc2-e9e4-0043-67fc54ca4740@gmail.com>
Date:   Tue, 12 Feb 2019 08:53:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

I would like to enhance the gas sensor support in the bme680 driver, but
I'm not sure how to fit the enhancement into IIO.

The bme680 has the following registers:
idac_heat_0 to 9 at 0x50..0x59 - initial current applied to heater
res_heat_0 to 9 at 0x5A..0x63 - target temperature of heater
gas_wait_0 to 9 at 0x64..0x6D - heater on duration

The ctrl_gas_1 register has an nb_conv<3:0> field which selects which of
the settings (0 to 9) to use for the gas sensor.

Currently, the driver just hard codes some values into res_heat_0 and
gas_wait_0.  idac_heat_0 is not written, but the datasheet says this is
optional.  I think it would be good if the user could configure these
parameters.  At a minimum it would be nice to expose one set of the
three values, but if I'm going to expose one, it seems like I might as
well expose all 10 and also allow the user to select which setting group
is active.

The current version of the driver has this for the gas channel definition:
{
	.type = IIO_RESISTANCE,
	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
},

Other channels of the device (such as temperature) support an
oversampling ratio, and are defined like this:

{
	.type = IIO_TEMP,
	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
			      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
},

I checked enum iio_chan_info_enum and there is no IIO_CHAN_INFO_
definition which seems applicable to "initial current", "target
temperature" or "heater duration".  How can I add these configuration
parameters in an idiomatic way?

Thanks,
David
