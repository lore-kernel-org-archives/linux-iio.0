Return-Path: <johnlm@apollo.lv>
Date: Tue, 4 Oct 2011 15:39:46 +0300
From: JohnLM <johnlm@apollo.lv>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Device-drivers-devel@blackfin.uclinux.org,
 manuel.stahl@iis.fraunhofer.de
Subject: Re: [RFC PATCH 0/2] IIO: Filtering - how to handle.
Message-ID: <20111004153946.77e9754d@isg005>
In-Reply-To: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
References: <1317377879-9264-1-git-send-email-jic23@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Fri, 30 Sep 2011 11:17:57 +0100
Jonathan Cameron <jic23@cam.ac.uk> wrote:

> Hi All,
> 
> One big area we have pretty much glossed over so far is devices with
> controllable hardware filters.  This RFC proposes one option for
> how to handle this. For low pass filters at least, the 3db point
> seems the obvious choice as it allows us to gloss over exactly
> what type of filter it is whilst still capturing it's basic
> property of what it lets through.
> 
> What do people think?
I have no exact filters in mind but in general since they affect the
readings I think some kind of framework is needed.
Some generic types should be defined, but even when IIO can't make out
what kind of filter it is, user-space app might so it should be exposed.

For filters that can be enabled/disabled userspace could even
abstract the filtering routine to use hardware filter when desired or
use software filter when hardware filter is not present or is
unreliable.

The implementation is a whole other story I don't have time to think
about right now. :)

> 
> Jonathan
> 
> Jonathan Cameron (2):
>   staging:iio: filter description - low pass 3db frequency.
>   staging:iio:imu:adis16400 add control of data filtering.
> 
>  drivers/staging/iio/iio.h                |    2 +
>  drivers/staging/iio/imu/adis16400.h      |    2 +
>  drivers/staging/iio/imu/adis16400_core.c |  177
> +++++++++++++++++++++++------
> drivers/staging/iio/industrialio-core.c  |    2 + 4 files changed,
> 146 insertions(+), 37 deletions(-)
> 
