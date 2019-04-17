Return-Path: <SRS0=A5Qb=ST=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F4CC282DA
	for <linux-iio@archiver.kernel.org>; Wed, 17 Apr 2019 15:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FF5205F4
	for <linux-iio@archiver.kernel.org>; Wed, 17 Apr 2019 15:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbfDQPIh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:08:37 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41802 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfDQPIh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Apr 2019 11:08:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id g6so17329848edc.8
        for <linux-iio@vger.kernel.org>; Wed, 17 Apr 2019 08:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9soMoojXcPj0LOnamcpj15uFD6H7U1rvlRy66ACWxFw=;
        b=QLklXV0gXenfpffnV/pLgii/wfcnYp+F67kRLLcDJQB0jQ/LqUt5zea3cEZ/lN99Q0
         HFEAQ/mzE9CjY5nwTd/e6lmm2UoB5tHADId6k+kBgAC8Y4aDVMGBm5wreQgL+niUAtAB
         R5g+y+3yh0+NDneVKJHQJ9dxHikqJ7yYhTbBz+qKkf/leeBfRS8Ej4qWRnyFdGi1yP0q
         NOW4oxHcQRWrIvb3cPMztZ70wejsQbiCl+NWE+o10ewSaRbont94TmYdxTOwJKJZcq1T
         DY4ZQ+6pjL7ZVCooTl+b4xE6v6BbEWmD24BnCOeOKRNRJRdnB8zgsfNzvw7bGiCbGy/L
         Laqg==
X-Gm-Message-State: APjAAAVtPwY7cMr6DjP/x3S3KkPrHeZt9RiIt+/6lu4vYxRgQzsn7rrq
        7QjSyEm3y0hh02RRoWM1mxx6P7IA7K8=
X-Google-Smtp-Source: APXvYqy67XVyf/HeNZFtJqRxH4Cmirc+ybQTbBZQqRVZ6giaDyTLYGRVL9Jbe4qpTNgwATKyd6tq/A==
X-Received: by 2002:a50:8822:: with SMTP id b31mr21925093edb.53.1555513715845;
        Wed, 17 Apr 2019 08:08:35 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g55sm7611edb.12.2019.04.17.08.08.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 08:08:34 -0700 (PDT)
Subject: Re: [PATCH] iio: accel: add missing sensor for some 2-in-1 based
 ultrabooks
To:     luis@aurorafoss.org
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <c2f3c22c-d491-17e7-ede7-54f9df11e064@redhat.com>
 <20190402160433.15810-1-luis@aurorafoss.org>
 <55a52a4e-01d1-2f4c-25e3-0047537bef86@redhat.com>
 <CAPyOxm8DyFjRxeL9QFHGW084cg5vhsKrwqGFy5rp8MEEZ3AHEQ@mail.gmail.com>
 <c34e15ec4be9d783c7134491639eb176@_>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9d8458a1-fc47-0727-4dc8-1d1eb185886d@redhat.com>
Date:   Wed, 17 Apr 2019 17:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c34e15ec4be9d783c7134491639eb176@_>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 15-04-19 17:40, luis@aurorafoss.org wrote:
> April 6, 2019 10:36 AM, "Hans de Goede" <hdegoede@redhat.com> wrote:
> 
> Hi,
> 
>> Yes that seems the best way forward with this.
>>
>> Note I think "base" is better then "keyboard" for the sensor which
>> is in the base/keyboard. But neither is perfect, so go which whatever
>> you prefer.
> 
> Reference to:
> - https://github.com/hadess/iio-sensor-proxy/pull/262 > - https://github.com/systemd/systemd/pull/12322

Thank you for your work on this, I see that Bastien has
already reviewed the iio-sensor-proxy changes.

I've just added one small remark to the systemd changes,
except for that small remark the systemd changes look good to me.

Regards,

Hams




>> On 06-04-19 01:01, Luís Ferreira wrote:
>>
>>> Hi,
>>> Basically we need to come up with a convention to (optionally) indicate
>>
>> the sensors location with a udev attribute set by:
>> /lib/udev/hwdb.d/60-sensor.hwdb
>>> So should we start adding `ACCEL_LOCATION=display` and
>>> `ACCEL_LOCATION=keyboard` attributes to that file and patch
>>> iio-sensor-proxy to ignore the keyboard ones as a first step ?
>>
>> Yes that seems the best way forward with this.
>>
>> Note I think "base" is better then "keyboard" for the sensor which
>> is in the base/keyboard. But neither is perfect, so go which whatever
>> you prefer.
>>
>> Thanks & Regards,
>>
>> Hans
>>
>>> On Wed, 3 Apr 2019 at 10:10, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 02-04-19 18:04, Luís Ferreira wrote:
>>> Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on display
>>> and KIOX020A sensor on keyboard base, to detect tablet mode or screen
>>> orientation.
>>
>> I deliberately left out the KIOX020A id for now, because currently
>> userspace cannot really deal with having 2 sensors.
>>
>> See:
>> https://github.com/systemd/systemd/issues/6557
>> https://github.com/hadess/iio-sensor-proxy/issues/166
>>
>> Basically we need to come up with a convention to (optionally) indicate
>> the sensors location with a udev attribute set by:
>> /lib/udev/hwdb.d/60-sensor.hwdb
>>
>> And then patch iio-sensor-proxy to consume that attribute and ignore
>> the one which has e.g. ACCEL_LOCATION=keyboard in its udev properties
>>
>> Ignoring would be a first step, maybe later it can do something useful
>> with it, see e.g. : https://github.com/alesguzik/linux_detect_tablet_mode
>>
>> IMHO we really should minimally get code in place for iio-sensor-proxy
>> to ignore the keyboard accelerometer before merging this patch.
>>
>> I realize that having the code in place will not magically get it on
>> all users machines, but I believe this is the minimum which needs to
>> happen before we push this out and potentially breaks people screen
>> rotation.
>>
>> I've had working on this on my TODO list for a long long time now,
>> but -ENOTIME. If you have some time to work on this then that would
>> be great.
>>
>> Regards,
>>
>> Hans
>>> Signed-off-by: Luís Ferreira <luis@aurorafoss.org>
>>> ---
>>> drivers/iio/accel/kxcjk-1013.c | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
>>> index 7096e577b23f..9a5e445facc1 100644
>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>> @@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>>> {"KIOX0009", KXTJ21009},
>>> {"KIOX000A", KXCJ91008},
>>> {"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
>>> + {"KIOX020A", KXCJ91008},
>>> {"KXTJ1009", KXTJ21009},
>>> {"KXJ2109", KXTJ21009},
>>> {"SMO8500", KXCJ91008},
