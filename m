Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <566C1208.4080405@kernel.org>
References: <1449332995-21695-1-git-send-email-jic23@kernel.org>
	<566C1208.4080405@kernel.org>
Date: Sat, 12 Dec 2015 14:30:16 +0200
Message-ID: <CAEnQRZAfoDf6Oyzq4gamg9U-Bu5cUnp104vYgOMbmsFF=dVvuQ@mail.gmail.com>
Subject: Re: [PATCH] iio:configfs: Introduce iio/configfs.h to provide a
 location for the configfs_subsystem
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Dec 12, 2015 at 2:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/12/15 16:29, Jonathan Cameron wrote:
>> This exported element needs to be accesible to all drivers using configfs
>> within IIO.  Previously it was in the sw_trig.h file which only convered one
>> such usecase.  This also fixes a sparse warning as it is now in a header
>> that makes sense to include from industrialio-configfs.c
>>
>> Signed-off-by: Jonathan Cameron < jic23@kernel.org>
> I guess no one cares or they are all happy with this :)
> Applied.

:)), I thought I already added my Acked-by on this. I have must been dreaming.
