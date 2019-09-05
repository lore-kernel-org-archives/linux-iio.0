Return-Path: <SRS0=sw36=XA=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86353C3A5A5
	for <linux-iio@archiver.kernel.org>; Thu,  5 Sep 2019 05:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D2B2173B
	for <linux-iio@archiver.kernel.org>; Thu,  5 Sep 2019 05:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="AUQ+eqjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfIEFaK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 5 Sep 2019 01:30:10 -0400
Received: from first.geanix.com ([116.203.34.67]:35488 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbfIEFaJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 01:30:09 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 18F0B63355;
        Thu,  5 Sep 2019 05:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567661398; bh=z4KAw3upBKjYBdpWRtVdqj7FD7t2rjeDmL/gvJoAb/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AUQ+eqjNTkiTtOKI5A9VifzHTV1OM/EyqCpm/qrUVtI/4nMwslJfNrnUpccDtICB8
         mxH1S8BHMRmtrrkA4GzDQRnb3l+IkdB2pkjBm19ZooOImUuSCO7cJcOBoJ1XiXtrg8
         T3w/KQkS4vWx/Hsdu2GknHHNW0KqGpXeGGFek+6eApHsWrefdoQRZGhZdFgWzq1WDj
         eEJyGcgvcZOP9bXsnG1cmGwe0mSSWyc3l20WjDVE25/8ZG5+lCj6HtIIoEmEHs2Wjv
         ZzP7eJRzkAhnF1ScYMUaZJX4Y/I3NML7KxUQzpJ/EXwC1wQq4DSxp5KS2laDFzJKw1
         NtvkPlqTR2bPg==
Subject: Re: [PATCH v3 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-2-sean@geanix.com>
 <20190904172400.GC2058@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d838c0a5-5396-de79-5ad3-45e421dda109@geanix.com>
Date:   Thu, 5 Sep 2019 07:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904172400.GC2058@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 04/09/2019 19.24, Lorenzo Bianconi wrote:

[..]

>> +	.scan_index = scan_idx,						\
>> +	.scan_type = {							\
>> +		.sign = 's',						\
>> +		.realbits = 16,						\
>> +		.storagebits = 16,					\
>> +		.endianness = IIO_LE,					\
>> +	},								\
>> +	.event_spec = &st_lsm6dsx_event,				\
>> +	.num_event_specs = 1,						\
>> +}
>> +
>>   #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> 
> I guess you can rename ST_LSM6DSX_CHANNEL in ST_LSM6DSX_CHANNEL_GYRO now
> 

We still have the channels for the magnetometer, which are similar to 
the gyro channels :-)

>>   {									\
>>   	.type = chan_type,						\
>> @@ -162,6 +183,13 @@ struct st_lsm6dsx_shub_settings {
>>   	u8 batch_en;
>>   };
>>   

/Sean
