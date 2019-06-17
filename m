Return-Path: <SRS0=PgFC=UQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8069FC31E5B
	for <linux-iio@archiver.kernel.org>; Mon, 17 Jun 2019 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C660208C4
	for <linux-iio@archiver.kernel.org>; Mon, 17 Jun 2019 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="idIy96hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFQQ3d (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:29:33 -0400
Received: from first.geanix.com ([116.203.34.67]:57996 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbfFQQ3c (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Jun 2019 12:29:32 -0400
Received: from [192.168.100.94] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 1889ED4C;
        Mon, 17 Jun 2019 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560788968; bh=O/3+hRgaDJ183ic5XPNYcjt1FwsMXDU9oMGi6lxEGlc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=idIy96hRF/yNznv8j4HXecPjSGi30Z3wKB+JZwgwpmu1eeAL1nJkBUkJQyTgs04Uo
         EsE7ww+O29YdLjopwpbXQRMhiu9VFM6DbLYJI3Qv8H+3Zjg27rpNz+AZBhpT9SroyU
         4XmXDMTwWYPbhFpVguEWNYmTAv9eImxAbLco6lUvL4Sl8L6ycNREy+ioqGvFQ93v/C
         qMT1AdBRJvGkNbH6WtFL6YeNvQC1ZN1msDKmQaq7uffxb8Bu1rAmqaMFowIjEGARJs
         ewk3SRvJde3I0m9GpfS4f2v7+SL0Tb+IJ3a5GVCTeLGQOD65qsKMDaWyZ4Kt/NI7qv
         k3dJALkkwvp/Q==
Subject: Re: [RFC PATCH 2/3] iio: imu: st_lsm6dsx: add wake on accelerometer
 enable hook in sysfs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
References: <20190614122604.52935-1-sean@geanix.com>
 <20190614122604.52935-3-sean@geanix.com> <20190616143035.0e845c8a@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <0bb53184-89e8-a007-8f8c-3f9ae14567a8@geanix.com>
Date:   Mon, 17 Jun 2019 18:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616143035.0e845c8a@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 16/06/2019 15.30, Jonathan Cameron wrote:
> On Fri, 14 Jun 2019 14:26:03 +0200
> Sean Nyekjaer<sean@geanix.com>  wrote:
> 
>> This adds a wakeup_enabled hook in sysfs.
>> If wakeup-source is enabled, wake on accelerometer event is default active.
>>
>> Signed-off-by: Sean Nyekjaer<sean@geanix.com>
> This seems to replicate the stuff that should be there under ../power
> to allow the wake up source to turned on and off..
> 

Hi,

Doh, I have already done it the correct way :-)
The hook is here:

root@host:~# cat /sys/devices/soc0/***/i2c-1/1-006a/power/wakeup
enabled

/Sean
