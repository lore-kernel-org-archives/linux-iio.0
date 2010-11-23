Return-Path: <jic23@cam.ac.uk>
Message-ID: <4CEBFE4B.4070500@cam.ac.uk>
Date: Tue, 23 Nov 2010 17:47:55 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: matthias <mensch0815@googlemail.com>, linux-iio@vger.kernel.org,
 m_brugger@web.de, drivers@analog.com
Subject: Re: [PATCH 0/2 V2] Adding support for adis16250/5 to adis16260 driver.
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>	<4C94B4A6.2060001@cam.ac.uk> <AANLkTinQ04UmbBvakGQBeSap0PCh3VrWmhhobLh0u9Qj@mail.gmail.com> <4CA0C7AB.8060905@cam.ac.uk>
In-Reply-To: <4CA0C7AB.8060905@cam.ac.uk>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 09/27/10 17:34, Jonathan Cameron wrote:
> On 09/18/10 16:48, matthias wrote:
>> Hi Jonathan,
>>
>> sorry for not answering yet. I was on vacation and next week I won't
>> be able to test the driver. Will try to do it asap....
>>
...

Matthias has now tracked down and fixed the issues he was having
(all outside this driver) and kindly tested and acked this patch set.
As such I've sent it on to Greg KH.  Would imagine it will show up
in staging next fairly shortly.

Jonathan
