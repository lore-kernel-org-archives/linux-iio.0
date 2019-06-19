Return-Path: <SRS0=LqLE=US=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58921C31E49
	for <linux-iio@archiver.kernel.org>; Wed, 19 Jun 2019 06:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C1820B1F
	for <linux-iio@archiver.kernel.org>; Wed, 19 Jun 2019 06:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hOtu1/GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfFSGa2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:30:28 -0400
Received: from first.geanix.com ([116.203.34.67]:48468 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSGa2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 19 Jun 2019 02:30:28 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id D2E4B345;
        Wed, 19 Jun 2019 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560925824; bh=rPfLhxJi+2oIXAvcokkMlTvFUL7qeGTImf480mmZF5I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hOtu1/GKc3KbKI50yKkkbDu3qr96D2OWh45g+NWWs5oY+OnEd/WKnqPHSDfLcwpL5
         wRtYxIjHOHZbGhhqqI2mdPqLI8oGxGQzIkgGYWaGpXGsCHFdsxvELysfzT4SoAB5oD
         ztmQVzdNvG9bD9aCDdJF/GoyMdJRzv9OD17K+wFo4qMtY8dbSSj2XxqfzaJu3v94B1
         syvTKgE51BrixEu0awV0qLeLsFhZ0LcISH6EzRwbA3KvPZitG8bu+Czzwchq5LhKKx
         7SiC6cLeNv/w3AG1VcaWUE75yPMC9vUdeUkq/tvszVbUhomul946i9OTf0Xqkq+4YP
         vBuyTIBxpHqwQ==
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-3-sean@geanix.com>
 <20190618154928.GB20044@localhost.localdomain>
 <e41ada28-a8b5-2911-7dd0-d8833debdcee@geanix.com>
 <20190618202142.GA930@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a6234f3d-9994-cc62-6365-39b43af3d196@geanix.com>
Date:   Wed, 19 Jun 2019 08:30:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190618202142.GA930@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 18/06/2019 22.21, Lorenzo Bianconi wrote:

>>>
>>> Could you please verify this registermap is used for all supported devices?
>>> (e.g. LSM6DS3 or LSM6DS3H)
>>
>> They have the same registers and the bits meaning the same.
>> But I can't test on those devices...
> 
> I do think so since BIT(7) of 0x58 TAP_CFG in LSM6DS3/LSM6DS3H is used to
> enable hw timestamp...moreover I think there are other differences
> 

The LSM6DS3/LSM6DS3H have the inactivity function enable in
WAKE_UP_THS 0x5B, BIT(6), ISM330 have that in TAP_CFG 0x58.
The rest of the WAKE_UP_THS have the same register layout

WAKE_UP_SRC 0x1B have the same register layout

MD1_CFG 0x5E have the same register layout

/Sean
