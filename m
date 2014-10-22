Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1413985817-10867-1-git-send-email-roberta.dobrescu@gmail.com>
Date: Wed, 22 Oct 2014 17:12:48 +0300
Message-ID: <CAEnQRZC2=1NaCfFjA6=TVU936LUzApobOgi5wPEOw6S4q3T29Q@mail.gmail.com>
Subject: Re: [OPW kernel] [PATCH v3] staging: iio: iio_event_monitor: Add
 support for missing IIO modifiers
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Cc: opw-kernel <opw-kernel@googlegroups.com>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 22, 2014 at 4:50 PM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch adds the missing IIO modifiers in event_is_known function
> and iio_modifier_names vector.
>
> Additionally, it removes duplicate name entries of IIO_MOD_LIGHT_BOTH
> and IIO_MOD_LIGHT_IR in iio_modifier_names.
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
