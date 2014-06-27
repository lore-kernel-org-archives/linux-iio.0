Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1403829626-17660-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1403829626-17660-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1403829626-17660-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Date: Fri, 27 Jun 2014 10:44:41 +0300
Message-ID: <CAEnQRZA+k6AKbAuCxntBFBiY0-m8Cba-ca-MKf+3S92b3kbAbA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] iio: core: add xyz modifier value
From: Daniel Baluta <daniel.baluta@intel.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jun 27, 2014 at 3:40 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> iio types defines a modifier called IIO_MOD_X_AND_Y_AND_Z, but since
> no modifier name is specified, it shows (null) as channel name.
> Here name is assiged a value "xyz".

Minor comments:
* s/assiged/assigned.
* it would be nice to add here the message from cover letter,
otherwise it will be lost on linux-iio archive :).

thanks,
Daniel.
