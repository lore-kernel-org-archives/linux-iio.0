Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37586 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCILM5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Mar 2018 06:12:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id 139so3235162wmn.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Mar 2018 03:12:56 -0800 (PST)
Subject: Re: GSoC IIO project: David Veenstra
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: linux-iio@vger.kernel.org
References: <9a4d5126-2087-bb75-88ed-f4a902ff7603@gmail.com>
 <516a7508-c151-52ec-d7dc-dc2df8dba1e3@gmail.com>
 <83BDCEE3-1946-40D9-94A9-B3B2EAA9E8C4@jic23.retrosnub.co.uk>
 <129b1789-3753-c6db-f854-d4b3e104f568@gmail.com>
 <20180308231721.3rte2dlplvcbbndg@smtp.gmail.com>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Message-ID: <536571c9-325f-e9fb-e9e3-bba017a7b992@gmail.com>
Date: Fri, 9 Mar 2018 12:12:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180308231721.3rte2dlplvcbbndg@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/2018 12:17 AM, Rodrigo Siqueira wrote:
> Hi David,
>
> On 03/08, David Julian Veenstra wrote:
>> On 03/08/2018 12:45 PM, Jonathan Cameron wrote:
>>> On 8 March 2018 10:58:23 GMT, David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
>>>> Dear IIO Community,
>>>>
>>>> For the Coding Task 01, I submitted the following patches:
>>>> https://marc.info/?l=linux-iio&m=152050249930598&w=2
>>>> https://marc.info/?l=linux-iio&m=152050245530583&w=2
>>>>
>>>> Jonathan, in reply to
>>>> https://marc.info/?l=linux-iio&m=151784107521336&w=2, do you have
>>>> a suggestion for a driver to move out of staging?
>>> In would take a look at the CDC or resolver drivers. I particular ABI on those..  let other list
>>>  know which you plan to take on to avoid duplication of effort.
>>>
>>> Jonathan
>> Alright. I'd like to take a look at the ad2s1200 and the ad2s1210
>> driver, although I have
>> no concrete plan yet.
> Today I inspected the AD2S1210 code, and I created a small work
> plan. However, I saw your message a few minutes ago. I have a
> suggestion: how about I work on AD2S1210 and you on AD2S1200? This
> strategy can bring more benefits to the community in my opinion. If you
> agree I will send my work plan, if not, that ok for me I can try to work
> on frequency module (actually, I believe that frequency is in the same
> situation of meter module).
>
>> Best regards,
>> David Veenstra
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Agreed. I'll take a look at the AD2S1200 driver.

Best regards,
David Veenstra
