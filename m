Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:33468 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHXRY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 18:17:24 -0500
Received: by mail-ua0-f176.google.com with SMTP id f6so1078805ual.0
        for <linux-iio@vger.kernel.org>; Thu, 08 Mar 2018 15:17:24 -0800 (PST)
Date: Thu, 8 Mar 2018 20:17:21 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Julian Veenstra <davidjulianveenstra@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: GSoC IIO project: David Veenstra
Message-ID: <20180308231721.3rte2dlplvcbbndg@smtp.gmail.com>
References: <9a4d5126-2087-bb75-88ed-f4a902ff7603@gmail.com>
 <516a7508-c151-52ec-d7dc-dc2df8dba1e3@gmail.com>
 <83BDCEE3-1946-40D9-94A9-B3B2EAA9E8C4@jic23.retrosnub.co.uk>
 <129b1789-3753-c6db-f854-d4b3e104f568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <129b1789-3753-c6db-f854-d4b3e104f568@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi David,

On 03/08, David Julian Veenstra wrote:
> On 03/08/2018 12:45 PM, Jonathan Cameron wrote:
> > On 8 March 2018 10:58:23 GMT, David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:
> >> Dear IIO Community,
> >>
> >> For the Coding Task 01, I submitted the following patches:
> >> https://marc.info/?l=linux-iio&m=152050249930598&w=2
> >> https://marc.info/?l=linux-iio&m=152050245530583&w=2
> >>
> >> Jonathan, in reply to
> >> https://marc.info/?l=linux-iio&m=151784107521336&w=2, do you have
> >> a suggestion for a driver to move out of staging?
> > In would take a look at the CDC or resolver drivers. I particular ABI on those..  let other list
> >  know which you plan to take on to avoid duplication of effort.
> >
> > Jonathan
> 
> Alright. I'd like to take a look at the ad2s1200 and the ad2s1210
> driver, although I have
> no concrete plan yet.

Today I inspected the AD2S1210 code, and I created a small work
plan. However, I saw your message a few minutes ago. I have a
suggestion: how about I work on AD2S1210 and you on AD2S1200? This
strategy can bring more benefits to the community in my opinion. If you
agree I will send my work plan, if not, that ok for me I can try to work
on frequency module (actually, I believe that frequency is in the same
situation of meter module).

> Best regards,
> David Veenstra
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
