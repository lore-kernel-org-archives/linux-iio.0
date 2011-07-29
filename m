Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E32EB4B.2020500@cam.ac.uk>
Date: Fri, 29 Jul 2011 18:18:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] staging:iio: remove broken support for multiple event
 interfaces.
References: <1311600911-20353-1-git-send-email-jic23@cam.ac.uk> <1311600911-20353-2-git-send-email-jic23@cam.ac.uk> <4E32EB21.2010000@cam.ac.uk>
In-Reply-To: <4E32EB21.2010000@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/29/11 18:17, Jonathan Cameron wrote:
> On 07/25/11 14:35, Jonathan Cameron wrote:
>> We don't have a use case for these.  Two drivers appeared to use them
>> but both report all events on the first.
> Silly bug in here as well.  It subtracts one from an unsigned before doing a
> comparison.  Result is that for some devices, the masklength will end up as 0
> and hence all sorts of fun will occur. Sorry about that, will be fixed in the
> git tree in a few mins.
Where this applies to the next patch not this one. Oops.
