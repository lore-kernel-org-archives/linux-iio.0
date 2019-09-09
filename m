Return-Path: <SRS0=8cOJ=XE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61040C4740A
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B32089F
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 10:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="QvHpHTSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfIIK1D (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:27:03 -0400
Received: from first.geanix.com ([116.203.34.67]:50660 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfIIK1D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 06:27:03 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 523F02D7;
        Mon,  9 Sep 2019 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568024793; bh=jFcs1OtpPRoMxPsyjvdnW3gXzs2esSSIG3gAzZUPBVs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QvHpHTSVwUMgLvwrvdq64rqOA7HHNmGGS/fpHhlo2p2nlCzvFxWlXDDgsb9izkHNB
         iHZEpPE8Yd0SC+jsDOykg9/E1kExON2zylleHFiZ7Lie6q5UqYfQwTqLbtD5RNztQV
         Q+qZS+B0tAbm23Amn1Pj61eimDw7j7Tylg8LbUPfOj6orY6pA/pXqMwvU4RTGlt2NN
         JWl8xnRtJ+hWQZAu16pq7xNv+JvrJg6Q9n+5jFNenumKCKgmFC7qKh0tVYbJmAO5Kh
         0quCVGMVJPFhNmP1mKo7tI/qd9NbLp/sV1SPc+N4okzR9CW72Au03IYCia2uVvpwDn
         7TInmuVe7nI5Q==
Subject: Re: [PATCH v5 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909094506.51792-1-sean@geanix.com>
 <20190909094506.51792-2-sean@geanix.com>
 <20190909102117.GA2990@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4e87bfae-ea15-a325-b4eb-232e6a370581@geanix.com>
Date:   Mon, 9 Sep 2019 12:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909102117.GA2990@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/09/2019 12.21, Lorenzo Bianconi wrote:
> You defined wakeup_src_{w,y,z}_mask in patch 5/6 and you are using them here. Please do not do so since you are breaking 'git bisect'
> 
> Regards,
> Lorenzo

My bad, will update in v6 :)

Will move the device sensor definitions to 5/6, so we avoid
"warning: variable ‘**’ set but not used"

/Sean
