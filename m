Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-007.synserver.de ([212.40.185.7]:1051 "EHLO
	smtp-out-004.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757024Ab3IOPjT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:39:19 -0400
Message-ID: <5235D500.8030403@metafoo.de>
Date: Sun, 15 Sep 2013 17:40:48 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V3 0/5] IIO: Refactor info_mask* and ext_info handling
 and introduce info_mask_shared_[by_all/by_type]
References: <1378648641-28280-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/2013 03:57 PM, Jonathan Cameron wrote:
> Changes since V2.
> 1) Fixed formatting in the iio_shared_by enum definition as pointed out
>    by Lars.
> 
> Changes since V1.
> 1) Deal with ext_info as well as the info_mask.
>    In the previous set things sort of worked by coincidence of the ordering
>    in the enum.  This version handles this cleanly.
> 2) Dropped the bonus const in tmp006.
> 
> Original message :
> 
> This series first performs a bit of refactoring of the core handling
> of info_mask_separate and info_mask_shared_by_type.
> 
> Next we introduce info_mask_shared_by_dir and info_mask_shared_by_all
> to allow for attributes of the form
> 
> in_sampling_frequency or sampling_frequency as appropriate.
> 
> Most existing drivers will make no use of the shared_by_dir
> case, but it is there to handle devices with both and input and
> output channels.
> 
> There are two main reasons for adding these two cases.
> 1) Should result in shorter code, particularly for complex drivers.
> 2) Allows for in kernel consumers accessing this functionality.
> 
> The intent is to follow this series with one providing a standard
> way of providing 'available' attributes.  The combination of the
> two should mean that very few things are still handled via direct
> registration of attributes.
> 
> Thanks,
> 
> Jonathan

Looks good to me, all patches

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> 
> Jonathan Cameron (5):
>   iio: drop info_mask from struct iio_dev
>   iio: refactor info mask and ext_info attribute creation.
>   iio: add info_mask_[shared_by_dir/shared_by_all]
>   staging:iio: dummy driver additions to show shared_by_dir infomask
>     usage
>   iio:temperature:tmp006 put sampling_frequency in
>     info_mask_shared_by_all
> 
>  drivers/iio/dac/ad5064.c               |   3 +-
>  drivers/iio/dac/ad5380.c               |   4 +-
>  drivers/iio/dac/ad5446.c               |   3 +-
>  drivers/iio/dac/ad5504.c               |   4 +-
>  drivers/iio/dac/ad5624r_spi.c          |   4 +-
>  drivers/iio/dac/ad5686.c               |   3 +-
>  drivers/iio/dac/ad5755.c               |   1 +
>  drivers/iio/dac/ad5791.c               |   5 +-
>  drivers/iio/dac/ad7303.c               |   1 +
>  drivers/iio/dac/mcp4725.c              |   3 +-
>  drivers/iio/frequency/adf4350.c        |   1 +
>  drivers/iio/iio_core.h                 |   2 +-
>  drivers/iio/industrialio-buffer.c      |   2 +-
>  drivers/iio/industrialio-core.c        | 179 ++++++++++++++++++++-------------
>  drivers/iio/temperature/tmp006.c       |  57 +++++------
>  drivers/staging/iio/iio_simple_dummy.c |  16 +++
>  include/linux/iio/iio.h                |  26 +++--
>  17 files changed, 197 insertions(+), 117 deletions(-)
> 

