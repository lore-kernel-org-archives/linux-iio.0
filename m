Return-Path: <SRS0=8cOJ=XE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E6C433EF
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 06:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C5221924
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 06:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="V7zlFLBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfIIGVh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:21:37 -0400
Received: from first.geanix.com ([116.203.34.67]:42450 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbfIIGVh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 02:21:37 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 332616E014;
        Mon,  9 Sep 2019 06:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568010068; bh=r257sbHAR4AyO8F785tN9UTkftlh7MaX4c1JsBWTUAk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V7zlFLBhOVHeZ1gX7NMQwR/ekahw0a6LVbqtD9TFRBjyFQFY7y/2or5io36osGM8r
         y2TZidp7P8Bgby4w2IT9zB1CozVzFFYthWBmK6zvj4YUFUX7ZoH4DtWBo180uJyGZL
         x1AtaU86F0fubSHUSP/1JYgmH0DKBq1Pppi00BtGKqHDLzl5vPNo4LZWFOjO8eJH1J
         Bv7r4VsPuJoT/Pz7ob1mXGDOLCgxcGjrmgNcZebS/64V7hyqVlCSvFD4kJKr521W/u
         8r1s0MRvECoKp4MM5hLBkxD/SvozZs0NzsKiBp7pqgE3naSJxD6g9IybaNYBzYlXsi
         SSgV37Naqdwiw==
Subject: Re: [PATCH v4 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, mario.tesi@st.com, armando.visconti@st.com,
        martin@geanix.com
References: <20190906121716.66194-1-sean@geanix.com>
 <20190906121716.66194-5-sean@geanix.com> <20190907120828.51834b73@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <166cd2f2-706d-5beb-d6ff-7f8fe1eb2704@geanix.com>
Date:   Mon, 9 Sep 2019 08:21:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190907120828.51834b73@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 07/09/2019 13.08, Jonathan Cameron wrote:
>>   			},
>> +			.wakeup_src_reg = 0x1b,
>> +			.wakeup_src_status_mask = BIT(4),
> Bit 4?  I just checked the LSM6DS3 data sheet and the
> Wakeup Event Detection status is bit 3.
> Bit 4 is the sleep event status...
> Also checked the LSM6DSL.
> 
Hi Jonathan

You are right :-)
Can't quite understand why it worked with bit 4, it still works by 
checking the correct BIT(3)

/Sean
