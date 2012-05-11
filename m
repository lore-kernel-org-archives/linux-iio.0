Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56847 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758115Ab2EKMeU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 08:34:20 -0400
Message-ID: <4FAD0746.9020603@kernel.org>
Date: Fri, 11 May 2012 13:34:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/3] iio: documentation: create frequency sub-folder and
 move dds docs
References: <1336138266-25480-1-git-send-email-michael.hennerich@analog.com> <1336138266-25480-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1336138266-25480-2-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/4/2012 2:31 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich<michael.hennerich@analog.com>
Hmm.. May not make sense as the Documentation/ABI/testing is flat...

We might want to do this for Documentation/iio/ but that doesn't cover 
this file...
>
> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
> ---
>   .../{ =>  frequency}/sysfs-bus-iio-dds              |    0
>   1 files changed, 0 insertions(+), 0 deletions(-)
>   rename drivers/staging/iio/Documentation/{ =>  frequency}/sysfs-bus-iio-dds (100%)
>
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds b/drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-dds
> similarity index 100%
> rename from drivers/staging/iio/Documentation/sysfs-bus-iio-dds
> rename to drivers/staging/iio/Documentation/frequency/sysfs-bus-iio-dds

