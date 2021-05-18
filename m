Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C582AC433ED
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A601D61042
	for <linux-iio@archiver.kernel.org>; Tue, 18 May 2021 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbhERJ23 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 18 May 2021 05:28:29 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:43684 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbhERJ21 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 May 2021 05:28:27 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee160a3885f1a8-8c1f2; Tue, 18 May 2021 17:26:56 +0800 (CST)
X-RM-TRANSID: 2ee160a3885f1a8-8c1f2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee860a3885e647-b4121;
        Tue, 18 May 2021 17:26:55 +0800 (CST)
X-RM-TRANSID: 2ee860a3885e647-b4121
Subject: Re: [PATCH] staging: iio: cdc: ad7746: Fix unnecessary check
 andassignment in ad7746_probe()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20210517150006.8436-1-tangbin@cmss.chinamobile.com>
 <20210518075254.GN1955@kadam>
From:   tangbin <tangbin@cmss.chinamobile.com>
Message-ID: <dfb7d829-94e6-2051-8795-79402160afdb@cmss.chinamobile.com>
Date:   Tue, 18 May 2021 17:27:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210518075254.GN1955@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Dan：

On 2021/5/18 15:52, Dan Carpenter wrote:
> On Mon, May 17, 2021 at 11:00:06PM +0800, Tang Bin wrote:
>> @@ -730,11 +730,7 @@ static int ad7746_probe(struct i2c_client *client,
>>   	if (ret < 0)
>>   		return ret;
>>   
>> -	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>> -	if (ret)
>> -		return ret;
>> -
>> -	return 0;
>> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>>   }
> This sort of thing is done deliberately as a style choice...  I probably
> wouldn't have written it that way myself, but there really isn't a
> downside to leaving it as-is.
>
> The unused "int ret = 0;" just introduces a static checker warning about
> unused assignments and disables the static checker warning for
> uninitialized variables so we want to remove that.
>
Got it, I will send this patch for you.

Thanks

Tang Bin



