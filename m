Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831E1C433ED
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4456F6143F
	for <linux-iio@archiver.kernel.org>; Fri,  7 May 2021 10:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhEGKeg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 7 May 2021 06:34:36 -0400
Received: from first.geanix.com ([116.203.34.67]:38952 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236966AbhEGKe3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 May 2021 06:34:29 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 2769E4680DE;
        Fri,  7 May 2021 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1620383608; bh=SMtSgp/ZGFRhvF6E9EotnnIixr2ykaPxr3U/VwoPIhQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=LjT1mouDRJ3ssGB502wfKX9OSZWH1xCgJP8FL2KR5sjyW+w3gAvyEWGaOmw/3Dqcw
         SQO/MhI+5TeOHdGMq/psX5tnOhBbHbhcFC0SwES3VRFpMh+oqJjG2nwso7G3o7Co/u
         SuHESvfmgraB6MoVD9bvrbI6OeYOw17Q94kLSy7o1YSHCCXikpfXNQIAFO/jWyjYvo
         pcoumpF3qSB7j+s+c+PiZKLqJ2cCPB4zCXAYW3sa+UXKvuvshMY+4Oi6jT9HZfRdin
         0oeCnUKoRI87M6ER3D9mwC/M7u0NgErAmWO7tDlQJOPzD3r89zRgbZa7NSTEXOwsVU
         W/SRJT5Sq+b/Q==
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: correct ODR in header
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
References: <20210507103149.2193932-1-sean@geanix.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <b4398a94-ccc3-5e35-4d3a-f6f676f23f57@geanix.com>
Date:   Fri, 7 May 2021 12:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210507103149.2193932-1-sean@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 07/05/2021 12.31, Sean Nyekjaer wrote:
> Fix wrongly stated 13 Hz ODR for accelerometers, the correct ODR is 12.5 Hz
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Sorry for double post :/



/Sean
