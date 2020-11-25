Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDCC5519F
	for <linux-iio@archiver.kernel.org>; Wed, 25 Nov 2020 12:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B54C5206E5
	for <linux-iio@archiver.kernel.org>; Wed, 25 Nov 2020 12:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="mNr1+xRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKYMF1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:05:27 -0500
Received: from www381.your-server.de ([78.46.137.84]:44304 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgKYMF1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 07:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=OSK++B2JHqE+/lOFx5PN3PESTeif6z4Viurm4GGr1MA=; b=mNr1+xRHDCh8Qc9aE1SGUy3tIu
        /sY7saPTafvhe8cchYvRgzxywuaLLNYAMh8i0Kb4TyyLqfIcqNrYc5bL5jWovbloTCzxVEWUO8d0R
        oCv9OaTQJBRsRqNPU/4P44C4TlCymzrqVLgQcO/c6eMA82MDjSoLzM+AH+3Hzx4RYuWtzCWmFAwFu
        cHWOqeyRQtfjfW7dLazi/K+Au2ZAQJBuBQl0fFlGJiDcZOpL0DUWRZtUIFb2HZyxmPQ5qsxAEvtOV
        3nVS/SgQc55WMgH1Pru1UeuBEIbaW4pbueT0uBd/bHr6gkNoEeQEpmMj8oFxrYWE/xmoat2iNYNzf
        jndkNAlA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1khtY4-0001iy-PV; Wed, 25 Nov 2020 13:05:24 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1khtY4-000Nx3-Ld; Wed, 25 Nov 2020 13:05:24 +0100
Subject: Re: fake ACPI IDs in the drivers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
 <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de>
 <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <57a87648-b329-6c79-21bb-629a7f4e43e0@metafoo.de>
Date:   Wed, 25 Nov 2020 13:05:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25998/Tue Nov 24 14:16:50 2020)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/25/20 1:00 PM, Andy Shevchenko wrote:
>> I'd assume that most drivers that have a acpi_device_id table do have
>> hardware that uses that ID and were not just cargo culted.
>>
>> For new drivers we should push back on unregistered IDs, but if there is
>> hardware that uses them we have to take the patches.
> Right. But at the same time we have to push the idea of proper IDs to
> the vendor companies, so they won't abuse ACPI specification anymore.

The last couple of years have made me very cynical on this. Vendors will 
ship whatever works, not what is correct.

