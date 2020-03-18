Return-Path: <SRS0=l2Gr=5D=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39CC10DCE
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 15:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6C920776
	for <linux-iio@archiver.kernel.org>; Wed, 18 Mar 2020 15:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="g89qvkF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCRPMj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:12:39 -0400
Received: from www381.your-server.de ([78.46.137.84]:44920 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRPMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 11:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jXFg+Lk+O8IuGT9rfESA6msiedOcS1jJ2FlUgALBYw4=; b=g89qvkF3dRfH3RvOnYstrWAAuX
        HRtboA4fvqnG3tafG9R6C8UJZMxnJTm/y/hi+yNUiLmajT0KBofTL8PENZVsIuoHCxjajGPuicf3H
        JpWZ0vstX0wTeZjDqf51lykgmKYxqJHYZQnI4z/fqPauMpSGmAAaaPn0jmsD8RkfufhO5TdeXhv13
        W/X/9WTiBlcUSMZh8+h/iBUhKKEoiCF2SpbrZvZOP0zNr6YcImNokt/W14hltX9ZrQmXx+6Lkh6eH
        ok67Q46HDdNb4jQ3TpxvK3LFQC+L1R6Eof1NfYlmoNq4s5qcKHO793K1e/S+zpccPbldIpdGAF+cR
        277l3ltQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEaMw-00035z-4Q; Wed, 18 Mar 2020 16:12:30 +0100
Received: from [93.104.115.49] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEaMv-00049T-Pn; Wed, 18 Mar 2020 16:12:29 +0100
Subject: Re: [PATCH 2/2] staging: iio: adc: ad7280a: Add spaces around
 operators
To:     Greg KH <gregkh@linuxfoundation.org>,
        Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, daniel.baluta@gmail.com,
        kieran.bingham@ideasonboard.com, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <cover.1584505215.git.mh12gx2825@gmail.com>
 <6703668c512dd665a2299a1f5bf14d99262314f8.1584505215.git.mh12gx2825@gmail.com>
 <20200318060038.GB1594471@kroah.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <35afdc4b-bd59-7851-aa4f-3d8807668931@metafoo.de>
Date:   Wed, 18 Mar 2020 16:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318060038.GB1594471@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25755/Wed Mar 18 14:14:00 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/18/20 7:00 AM, Greg KH wrote:
> On Wed, Mar 18, 2020 at 09:58:13AM +0530, Deepak R Varma wrote:
>> Add spaces around operator symbols to improve readability. Warning
>> flagged by checkpatch script.
>>
>> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
>> ---
>>   drivers/staging/iio/adc/ad7280a.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
>> index 19a5f244dcae..34ca0d09db85 100644
>> --- a/drivers/staging/iio/adc/ad7280a.c
>> +++ b/drivers/staging/iio/adc/ad7280a.c
>> @@ -825,14 +825,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>>   }
>>   
>>   static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
>> -			     in_voltage-voltage_thresh_low_value,
>> +			     in_voltage - voltage_thresh_low_value,
>>   			     0644,
>>   			     ad7280_read_channel_config,
>>   			     ad7280_write_channel_config,
>>   			     AD7280A_CELL_UNDERVOLTAGE);
>>   
>>   static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
>> -			     in_voltage-voltage_thresh_high_value,
>> +			     in_voltage - voltage_thresh_high_value,
>>   			     0644,
>>   			     ad7280_read_channel_config,
>>   			     ad7280_write_channel_config,
> 
> Did you try building this code?
> 
> It catches everyone...

The problem is it builds. The token is stringyfied and
"in_voltage - voltage_thresh_high_value" is a valid string.

- Lars
