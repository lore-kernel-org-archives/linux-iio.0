Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48056 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941508AbdAGRy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2017 12:54:28 -0500
Subject: Re: [PATCH v4] staging: iio: ad7606: replace range/range_available
 with corresponding scale
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1483787423-7357-1-git-send-email-eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, amsfield22@gmail.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3ebd18b1-f61a-ee99-f603-c24a419ea966@metafoo.de>
Date: Sat, 7 Jan 2017 18:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <1483787423-7357-1-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/07/2017 12:10 PM, Eva Rachel Retuya wrote:
> Eliminate the non-standard attributes in_voltage_range and
> in_voltage_range_available. Implement in_voltage_scale_available in place
> of these attributes and update the SCALE accordingly. The array
> scale_avail is introduced to hold the available scale values.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
