Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25FC433B4
	for <linux-iio@archiver.kernel.org>; Thu, 15 Apr 2021 17:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFF9611BF
	for <linux-iio@archiver.kernel.org>; Thu, 15 Apr 2021 17:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhDORvc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:51:32 -0400
Received: from first.geanix.com ([116.203.34.67]:35396 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233551AbhDORvc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 13:51:32 -0400
Received: from [192.168.16.66] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id 9FD5046364D;
        Thu, 15 Apr 2021 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1618509066; bh=vYAJWRFyhmjngiYajeb9a8he7H/cNjOrwpF4lRHj13s=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=FD/ysOC8ahVN1mvORi/AjS9Lf2W5pzuDzLYgtsjEkWYsGQNDUQNygg7bRvoFYhZBc
         b0wYL4tFNKgiL7OA8yiZluax2YZP58CnuH3BQuGezeyY9eQX3DCzDLKURcdX0+0sLq
         wYSmCXYTu8zilChWgqTeWSdzCoy4GeFWFWXHKD3yQX53Mi4McNLZx0+9/Abf+Kw0DY
         9Ucp46dpflCO+vRH2/qMeu5WJuTqRN/GN7CfeG2fD+qDaTV2jclJn8fWA6F3eoJx9g
         Jp8UmlOjilERI+ueaG7npOxDH9VeY5e3EXIGMkuJQoQL9RadZ0ZboxT3+xHS1Q7BcL
         7SqCS/DwW9Kwg==
Subject: Re: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF
 accelerometers
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20210415114614.1071928-1-sean@geanix.com>
 <CY4PR03MB31127BA6AD9A0F7DCF295ED0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <634cf024-dc01-431a-4955-88b453e2c629@geanix.com>
Date:   Thu, 15 Apr 2021 19:51:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR03MB31127BA6AD9A0F7DCF295ED0994D9@CY4PR03MB3112.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 15/04/2021 17.10, Sa, Nuno wrote:
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_set_autosuspend_delay(dev,
>> FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
>> +	pm_runtime_use_autosuspend(dev);
> Maybe add devm_add_action_or_reset() here and after enabling the
> regulator and we can then ditch ' fxls8962af_core_remove ()'...
Thanks for the review :)
I'm think not able to ditch the fxls8962af_core_remove() I still have 
the pm_runtime stuff or can they be removed via some devm_ functions?

/Sean
