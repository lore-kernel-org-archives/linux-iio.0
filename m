Return-Path: <SRS0=oRg9=ZV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD550C432C3
	for <linux-iio@archiver.kernel.org>; Fri, 29 Nov 2019 09:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D91B215A5
	for <linux-iio@archiver.kernel.org>; Fri, 29 Nov 2019 09:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RG0O8YxU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfK2JOg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:14:36 -0500
Received: from first.geanix.com ([116.203.34.67]:52096 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK2JOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Nov 2019 04:14:35 -0500
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 4D99494290;
        Fri, 29 Nov 2019 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1575018641; bh=ifdZ+4J6yKvqea+7k1QNmsgvAKINRDTlXEQ605iZqJo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RG0O8YxUbtuJznUl15ZA0Nx3xcqjKXQrvvDN/tNN3tNdbvzWQd35XA+WwYj0Pz0TR
         Wb0YpfKhKBO6FV3zdA5hghUgf9FbgWF1GtJob9WSPKPRRwkDpVojENizIzITFDR8Pi
         GNTb13UjJImSUBZgavlqv1cH/YZVWa99hwHaCeL2BCSNYUBkb5BuNa3VJL6j02eM+f
         BJd/yhcNyi0Dw04L0KWNrhGz/So6MN/yCr+Hf943yelx0G39K4IDYK07ek2RMBNJIX
         YzlYu7Gv7g7xnT9Vvf77czEYO8DTO5ivDqtK+8QLzMHZn0EI1JK5ARA0Fqe33gl7AF
         aQSgQbFr96wkQ==
Subject: Re: [RFC/RFT] iio: imu: st_lsm6dsx: do not power-off accel if events
 are enabled
To:     Lorenzo Bianconi <lorenzo@kernel.org>, jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
References: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <f3a503f1-2371-1e14-027e-a6465b2d243e@geanix.com>
Date:   Fri, 29 Nov 2019 10:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 28/11/2019 20.18, Lorenzo Bianconi wrote:
> Do not power-off accel unconditionally if wake-up events are enabled
> powering off the hw FIFO. At the same time do not power-off the accel
> sensor if it is 'batched' in the hw FIFO disabling sensor events
> 
> Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This patch is based on https://patchwork.kernel.org/patch/11266301/
> @Sean: could you please run some tests in your environment?

Hi,

Works as expected in our environment. :)

/Sean
