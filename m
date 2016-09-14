Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35689 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764135AbcINQAp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2016 12:00:45 -0400
Received: by mail-pf0-f178.google.com with SMTP id z123so6995129pfz.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Sep 2016 09:00:40 -0700 (PDT)
Message-ID: <1473868832.9913.14.camel@researchut.com>
Subject: Re: possible odd acceleration scaling
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Bastien Nocera <hadess@hadess.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Wed, 14 Sep 2016 21:30:32 +0530
In-Reply-To: <1473867872.6389.16.camel@hadess.net>
References: <1473787814.8047.8.camel@researchut.com>
         <a9078c9f-0d07-35bc-e449-2cfeee7b7987@kernel.org>
         <d275ff67-4335-a6f4-b60b-c4227a59b34c@kernel.org>
         <1473793566.6874.10.camel@linux.intel.com>
         <1473843953.23872.3.camel@researchut.com>
         <1473845312.23872.5.camel@researchut.com>
         <1473861009.9913.7.camel@researchut.com>
         <1473866880.35049.5.camel@linux.intel.com>
         <1473867872.6389.16.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Bastien,

On Wed, 2016-09-14 at 17:44 +0200, Bastien Nocera wrote:
> 
> My guess:
> -       return (int) (info_1->index - info_2->index);
> +       return ((int) info_1->index - (int) info_2->index);
> 
> Ritesh, could you try to change those lines in compare_channel_index()
> in src/iio-buffer-utils.c and capture another log if it fails?

That did not seem to change anything. I've put up the log at:
https://people.debian.org/~rrs/tmp/iio-int.txt

 
- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2XQhAAoJEKY6WKPy4XVp0G8P/jL93VwzPKnbrjR/B2hgVLXG
SQc0WV6mNgNOUDcUfbEkSv/Fk4cNLMTIqRw9u/oTA4ZM5+omZUF4C0iZnNKx/f5C
/1Q6rxKUVVn/ET31mG5vw/05MUqJqMN86LdJKgvno4ndmE1/hsF5CAn8vo5WRBr7
V7XM6gPdEBfXQnIHd64nrbHADjsXAB2WxL+tqhXzjxOBUO2wdL/oXYivqij92niN
TtHEiHQZLqnHfGOTKPPGaF39mDQJsmEf4AWCnlfHwugGN1EIZGaXZSbOsO/c6su8
/SQQta1HmrVrodVVT/dITKGLPxbyYa0ei7LAp16BcrK0HXeV/1hQ0c4h8Brlg0du
5W3a0GkbvXz4YcyRypRxHoNR6iel001k7ndWMYBFixWhTzUbNYhgf6QZU8seXyot
yqDSAnxY9KJEasGtVG/SSQ8kRl4iIyq3JG3HqRxMvDWffZSm90HsWQ+KBKX8QzGJ
X6A6SlotyWvnSGsWF/YAv2n952NQGdpzIdlJd9rTaXpzCJY4rh6eSCg/tP1oBgul
GxY6G8OQy0zvfvcAl31Kxi1JOoOidlbyeYqs4wsSIAHJpKFlAd1Jw6agmk7JuwH6
UE450+9u1Pk6klWnR6GGB5Q3xNO6+JxnFzr3Zp93wu45za6fUFZcCk8n/esDqyqq
KsQ/LKGRoYi3M8ZJfF9i
=ZUpR
-----END PGP SIGNATURE-----

