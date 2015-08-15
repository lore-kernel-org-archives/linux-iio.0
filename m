Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47610 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbbHOPJO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 11:09:14 -0400
Subject: Re: [PATCH 0/2] Documentation: iio-trig-sysfs: Add missing ABI
To: Cristina Opriceana <cristina.opriceana@gmail.com>
References: <cover.1439378363.git.cristina.opriceana@gmail.com>
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF5618.7040808@kernel.org>
Date: Sat, 15 Aug 2015 16:09:12 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1439378363.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/15 12:26, Cristina Opriceana wrote:
> Add the ABI documentation for the add_trigger and remove_trigger
> attributes, found in iio-trig-sysfs.
> 
> Cristina Opriceana (2):
>   Documentation: iio-trig-sysfs: Document add_trigger attribute
>   Documentation: iio-trig-sysfs: Add remove_trigger attribute ABI
> 
>  .../ABI/testing/sysfs-bus-iio-trigger-sysfs        | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
These two could easily have been one patch given their paired nature,
but I don't care that much.

Applied to the togreg branch of iio.git (fuzz due to a pervious patch in there)

Thanks,

Jonathan
