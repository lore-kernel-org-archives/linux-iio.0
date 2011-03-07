Return-Path: <marten.svanfeldt@gmail.com>
Message-ID: <4D7471F8.5050603@gmail.com>
Date: Mon, 07 Mar 2011 13:49:44 +0800
From: Marten Svanfeldt <marten.svanfeldt@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: High frequency software trigger
References: <4D709432.90003@gmail.com> <544AC56F16B56944AEC3BD4E3D59177133FA70B26C@LIMKCMBX1.ad.analog.com> <4D70BFCD.40605@gmail.com> <4D70C8AA.4090300@cam.ac.uk>
In-Reply-To: <4D70C8AA.4090300@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 2011-03-04 19:10, Jonathan Cameron wrote:
> I'm only superficially familiar with the abilities of hrtimers.
> Perhaps you could post your current code as an RFC so we can get an idea of exactly
> how this would work?

Right now my work is a mix of driver interfacing code and triggering, 
being the result of hacking away during my thesis work. I will try to 
write a cleaner hrtimers based trigger during the next week(s) and send 
it for review, with the limit of not having access to our target 
platform right now so testing will be limited.

Regards
Marten Svanfeldt
