Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36676 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeCHVae (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 16:30:34 -0500
Received: by mail-wm0-f44.google.com with SMTP id 188so443502wme.1
        for <linux-iio@vger.kernel.org>; Thu, 08 Mar 2018 13:30:34 -0800 (PST)
Subject: Re: GSoC IIO project: David Veenstra
To: linux-iio@vger.kernel.org, jic23@kernel.org
References: <9a4d5126-2087-bb75-88ed-f4a902ff7603@gmail.com>
 <516a7508-c151-52ec-d7dc-dc2df8dba1e3@gmail.com>
 <83BDCEE3-1946-40D9-94A9-B3B2EAA9E8C4@jic23.retrosnub.co.uk>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Message-ID: <129b1789-3753-c6db-f854-d4b3e104f568@gmail.com>
Date: Thu, 8 Mar 2018 22:30:32 +0100
MIME-Version: 1.0
In-Reply-To: <83BDCEE3-1946-40D9-94A9-B3B2EAA9E8C4@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/2018 12:45 PM, Jonathan Cameron wrote:
> On 8 March 2018 10:58:23 GMT, David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
>> Dear IIO Community,
>>
>> For the Coding Task 01, I submitted the following patches:
>> https://marc.info/?l=linux-iio&m=152050249930598&w=2
>> https://marc.info/?l=linux-iio&m=152050245530583&w=2
>>
>> Jonathan, in reply to
>> https://marc.info/?l=linux-iio&m=151784107521336&w=2, do you have
>> a suggestion for a driver to move out of staging?
> In would take a look at the CDC or resolver drivers. I particular ABI on those..  let other list
>  know which you plan to take on to avoid duplication of effort.
>
> Jonathan

Alright. I'd like to take a look at the ad2s1200 and the ad2s1210
driver, although I have
no concrete plan yet.

Best regards,
David Veenstra
