Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34443 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbCTIsy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 04:48:54 -0400
Received: by wibg7 with SMTP id g7so22948106wib.1
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2015 01:48:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426506500-11836-1-git-send-email-darshanapadmadas@gmail.com>
References: <1426506500-11836-1-git-send-email-darshanapadmadas@gmail.com>
Date: Fri, 20 Mar 2015 10:48:52 +0200
Message-ID: <CAEnQRZDvupQzUVNtTRNyHSQG1tJpHcZMPkKOkM3j=TdXAN6ZXw@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: Add ABI documentation for
 illuminance raw and scale values in light
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Darshana Padmadas <darshanapadmadas@gmail.com>
Cc: outreachy-kernel@googlegroups.com,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 16, 2015 at 1:48 PM, Darshana Padmadas
<darshanapadmadas@gmail.com> wrote:
> This patchset adds ABI documentation for the following attributes:
>
> in_illuminance_scale, used atleast once in al3320a staging/iio/light/

Reference to staging/iio/light here is confusing. People might think
that al3320 is in staging, while staging is your source tree top directory.

Better drop it :).

Also s/atleast/at least/

Just say:

in_illuminance_scale, exported by  al3320a ambient light sensor.

> in_illuminance_calibscale, used atleast once in cm32181
> in_illuminance_input, used in cm3232 at least once
> in_illuminance_raw used atleast once in al3320a
> in_illuminance_clear_raw and in_illuminance_ir_raw exposed by
> gp2ap020a00f with modifiers IIO_MOD_LIGHT_CLEAR and
> IIO_MOD_LIGHT_IR respectively.

The same for all the above.

Other than that, the patch looks good to me.

Daniel.
