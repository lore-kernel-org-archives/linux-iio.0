Return-Path: <lars@metafoo.de>
Message-ID: <54CF464F.9000306@metafoo.de>
Date: Mon, 02 Feb 2015 10:41:35 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Nicholas Mc Guire <hofrat@osadl.org>
CC: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: ad_sigma_delta: cleanup wait_for_completion
 return handling
References: <1422866258-10517-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1422866258-10517-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 02/02/2015 09:37 AM, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int, rather
> than introducing a new variable the wait_for_completion_timeout is moved
> into the if condition as the return value is only used to detect timeout.

But the return value is bound by the timeout parameter and we know that fits 
into a int. And I really dont like moving the function call into the if 
condition, so unless there is some additional explanation why this is 
necessary and should be done I'm inclined to nack this.

>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
>
> Aside from the fixup of the wait_for_completion_timeout handling
> a minor coding style issue in the else branch was fixed - the {} is
> not needed for the one-line body.

If one of the branches of a conditional statement has braces the other 
branches should also have braces. This is documented in 
Documentation/CodingStyle.
