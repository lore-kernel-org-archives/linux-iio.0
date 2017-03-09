Return-Path: <SRS0=LbjG=2S=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: sw-device: Fix config group initialization
To: Jonathan Cameron <jic23@kernel.org>
References: <1489076404-11490-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@gmail.com>,
 Miguel Robles <miguel.robles@farole.net>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <88d7a6cd-6fe6-b5ac-47e7-e8872ea77242@metafoo.de>
Date: Thu, 9 Mar 2017 17:24:22 +0100
MIME-Version: 1.0
In-Reply-To: <1489076404-11490-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/09/2017 05:20 PM, Lars-Peter Clausen wrote:
> Use the IS_ENABLED() helper macro to ensure that the configfs group is
> initialized either when configfs is built-in or when configfs is built as a
> module. Otherwise software device creation will result in undefined
> behaviour when configfs is built as a mdoule since the configfs group for

typo: module

> the device not properly initialized.
