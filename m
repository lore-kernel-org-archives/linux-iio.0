Return-Path: <SRS0=0vE5=TL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D213C04AB1
	for <linux-iio@archiver.kernel.org>; Sat, 11 May 2019 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BE82173B
	for <linux-iio@archiver.kernel.org>; Sat, 11 May 2019 12:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VnXXrK2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfEKMDU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 11 May 2019 08:03:20 -0400
Received: from first.geanix.com ([116.203.34.67]:42658 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfEKMDU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 08:03:20 -0400
Received: from [192.168.100.11] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 9BCDB9D3;
        Sat, 11 May 2019 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557576139; bh=mOcJnjIcGNNQknjvDPRVciqhxx6TBmGZcMSVi5Ve/Ac=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VnXXrK2hIDkEsCnM3j4eUT+xiGKF3qLVkhPyW5GzTocUG6RK+9DNEYFh0nWMZTj/i
         njLA4o+RYL6ao2ru4Y5kwuJC0ESmyUDe3/h6y0JvJsqeaNk90zXLvfo5dEZZWEDzwI
         IDDWD8xHWS2dB07lYMpSGwlBSM7mTGKulIngKD+u36dilxc4EfgcPTv+OPnDYf/OSn
         xyLLULi+JUZ9znnbAnGqvMJiQqwOcapUJ8ffHlkGgUyfwZECvhkEJkZRsrCW/yr4db
         LzCawBCeRppkUNE0jNB8JIZ1jWpQq2/+HpQN++dxzuJQ9vkm+AkxcaylY34jjy9uac
         h7Xq1w1cM8neg==
Subject: Re: [PATCH 1/2] iio: adc: ti-ads8688: save values correct in buffer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <20190507082304.11692-1-sean@geanix.com>
 <20190511124417.1b5bbf23@archlinux>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d858d6d8-59ef-dee1-92ae-e1f896b1b745@geanix.com>
Date:   Sat, 11 May 2019 14:03:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511124417.1b5bbf23@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 11/05/2019 13.44, Jonathan Cameron wrote:
> On Tue,  7 May 2019 10:23:03 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
>> Fill the read values in the buffer so we comply
>> with the given index values.
> Why?
> 
> They are not supposed to always remain in the same place. If some channels
> are turned off then they will shift 'down'.  That has to happen in general
> to allow us to do more efficient packing when they happen to fit into a
> smaller power of 2 size.
> So if channels 0-3 (8 bits each) are enabled and timestamp, it should be
> 
> 0 1 2 3 X X X X Timestamp, 0 1 2 3 X X X X Timestamp..
> 
> If no timestamp it should fall back to the packing
> 0 1 2 3, 0 1 2 3
> 
> If only channels 0, 1 and 3 we should get
> 
> 0 1 3 X, 0 1 3 X (padding to 32 bits)
> 
> For only 0 and 3
> 0 3, 0 3, 0 3
> 
> For only 0
> 0, 0, 0, 0, 0, 0
> 
> Jonathan
> 
Thanks for clarifying :-)

/Sean
