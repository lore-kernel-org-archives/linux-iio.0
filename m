Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 2/2] staging: iio: ad7606: move out of staging
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
 devel@driverdev.usuosl.org, linux-kernel@vger.kernel.org
References: <1478846078-22207-1-git-send-email-eraretuya@gmail.com>
 <1478846078-22207-3-git-send-email-eraretuya@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <266c2aad-1938-1dc7-0b22-b2f3b2d80e68@metafoo.de>
Date: Fri, 11 Nov 2016 15:22:09 +0100
MIME-Version: 1.0
In-Reply-To: <1478846078-22207-3-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/11/2016 07:34 AM, Eva Rachel Retuya wrote:
> Move the ad7606 driver from staging/iio/adc to iio/adc. Also, update the
> corresponding Makefile and Kconfig associated with the change.

This is obviously OK, but when you generate a patch that moves files use
`git format-patch -M ...`. This will generate a more compact patch.
