Return-Path: <SRS0=Kgok=XG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAAAC5ACAE
	for <linux-iio@archiver.kernel.org>; Wed, 11 Sep 2019 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C8D20863
	for <linux-iio@archiver.kernel.org>; Wed, 11 Sep 2019 12:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="IXDssDVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfIKMlb (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:41:31 -0400
Received: from first.geanix.com ([116.203.34.67]:52680 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbfIKMlb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Sep 2019 08:41:31 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 6B998646EF;
        Wed, 11 Sep 2019 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568205652; bh=YjOJKOOlFNkdNWBefyO+Ry1sbSKDS3gGXKsLpAUbWjc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IXDssDVdXXGwvbVFtl+rTJqsxFSLE9/eMJrHpDLxIg/eY9bXIC1N9gtpKZgS2DHdz
         838Dc94vrrjRf3s1HWxGId8LxVpsLOGqXX6YEiXNHWIi03IQSixUr5/08DOAmj6UMa
         +NxH8kYGo3g5AIS+AiXf9wZd2LI2kBzpOm3SlR7xyHm6fuUH+hIoKJdW+Ql63grj9b
         pLG2mqPvkjqTQf+k0rJY5uEW+sk/EmDOIUlnbJDrHk6vA/niShMrKSBnTr0Eer7agh
         cJdcIdovu7cJKUHRY5jRBkAOsEwh/S6PT01oiwjVvYlHhbLZDBoKuqLJd8TUxf3boj
         KkNZ8PA93MLCw==
Subject: Re: [PATCH v6 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909112846.55280-1-sean@geanix.com>
 <20190909112846.55280-5-sean@geanix.com>
 <20190909120546.GE2990@localhost.localdomain>
 <6e987a54-250c-c146-cff8-99fa33255f9b@geanix.com>
 <20190910071250.GA2712@localhost.localdomain>
 <58121fe6-067f-4515-3375-735ca7b41df6@geanix.com>
 <20190910072646.GB2712@localhost.localdomain>
 <20190910122740.GC2712@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <632ea600-509e-ad83-4752-6e6fc3000345@geanix.com>
Date:   Wed, 11 Sep 2019 14:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190910122740.GC2712@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/09/2019 14.27, Lorenzo Bianconi wrote:
>> Could you please try to carry out the following test?
>> 1- set the FIFO watermark to a high level (e.g. 128)
>>     $echo 256 > /sys/bus/iio/devices/iio:device{x}/buffer/length
>>     $echo 128 > /sys/bus/iio/devices/iio:device{x}/buffer/watermark
>> 2- set a low acc odr (e.g 13Hz)
>>     $echo 13 > /sys/bus/iio/devices/iio:device{x}/sampling_frequency
>> 3- start reading from the accel and generate a wake-upp event
>>
>> Is still happen? Are you able to decode bus transaction? (register addresses,
>> data read, ..)
>>

Do you still want this tested?

[...]

> Could you please try to enable the LIR (Latched interrupt - BIT(0) in 0x58)?
> Please remember that on ISM330DLC the interrupt will be automatically cleared
> reading the wake up src register after a time slice equals to 1/ODR so the it
> will be set for longer time if you run the device at low ODR


"iio: imu: st_lsm6dsx: enable LIR for sensor events"
"iio: imu: st_lsm6dsx: enable clear on read for latched interrupts"
Does allow us to get events and buffered reads simultaneously.

I will drop PATCH 6/6.

/Sean
