Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45113 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753458AbdBKKRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 05:17:01 -0500
Subject: Re: [PATCH 0/2] Documentation: iio: Fix KernelVersion lines in
 counter sysfs ABI documentation
To: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
References: <cover.1486562053.git.vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cc90f427-f45d-4e04-6b9c-acf824534149@kernel.org>
Date: Sat, 11 Feb 2017 10:16:57 +0000
MIME-Version: 1.0
In-Reply-To: <cover.1486562053.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/17 14:01, William Breathitt Gray wrote:
> The IIO counter driver support did not appear in the 4.9 version of the
> Linux kernel. The sysfs ABI documentation merged had incorrectly
> anticipated a version 4.9 release. However, the relevant patches ended
> up in the 4.10 merge instead. This patchset fixes the KernelVersion
> lines of the relevant IIO counter and 104-QUAD-8 IIO driver sysfs ABI
> documentation.
> 
> William Breathitt Gray (2):
>   Documentation: iio: Fix KernelVersion in counter sysfs ABI
>     documentation
>   Documentation: iio: 104-quad-8: Fix KernelVersion in sysfs ABI
>     documentation
> 
>  Documentation/ABI/testing/sysfs-bus-iio                |  4 ++--
>  .../ABI/testing/sysfs-bus-iio-counter-104-quad-8       | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
Not in the super important category, but why not have it correct I guess ;)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to completely ignore.

Jonathan
