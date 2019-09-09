Return-Path: <SRS0=8cOJ=XE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CADC00307
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0173721920
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 06:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bFwZccQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfIIGmV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 9 Sep 2019 02:42:21 -0400
Received: from first.geanix.com ([116.203.34.67]:42758 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfIIGmV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 02:42:21 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 5D28A62826;
        Mon,  9 Sep 2019 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568011312; bh=gec7ILZJ5aS8kit+qPbRly+7P7FUDHqFqWstMP/YpCg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=bFwZccQT8crvMwplIcomAhFNHS1eC3c1ie9F9SMJ90LVL3v+rqeei8w46tUkpJSk1
         CNJqzmIaEFBAVfvedCLkaUSnwA1A6CTZigcO/OQ1LvzMIh/1DpuyIoio0BDUpnXkLX
         dKsNO9i4mIBoyu6I6V0sREc9Q7jhrvXIpmUvn+OsDOiOTG7OfQHcbMjuLkvOHRr5Kz
         jnkLEqoq7s5SaA/VsNcvSkJq/rFmgbDKlzy0Xm5udIv/8vQuohIjGBwWVkTzFMO/NX
         gh6J+BLFa8qhjI8U2oQ0EzmgLDsyxIbVUJgnm+GjqZYEQtLEzS5b5UCpSjYA72lO0L
         oZ79GsJTSI96A==
Subject: Re: [PATCH v4 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190906121716.66194-1-sean@geanix.com>
 <20190906121716.66194-2-sean@geanix.com>
 <20190906140238.GB4515@localhost.localdomain>
 <20190906141330.GD4515@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <5cb1163d-756e-4b2b-efe9-3c27bf6dd946@geanix.com>
Date:   Mon, 9 Sep 2019 08:41:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190906141330.GD4515@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 06/09/2019 16.13, Lorenzo Bianconi wrote:
>>> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
>>> +{
>>> +	int err;
>>> +	u8 enable = 0;
> here you do something like:
> 
> 	if (!hw->settings->event_settings.enable_reg.addr)
> 		return -ENOSUPP;
> 

Here we need to do something else the LSM6DS3 doesn't feature this 
enable register.
My best guess it's enough to enable the routing of the interrupt in the 
MD register

/Sean
