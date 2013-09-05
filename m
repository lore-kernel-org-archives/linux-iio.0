Return-Path: <lars@metafoo.de>
Message-ID: <5228DAC9.8070804@metafoo.de>
Date: Thu, 05 Sep 2013 21:26:01 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH V2 0/5] IIO: Refactor info_mask* and ext_info handling
 and introduce info_mask_shared_[by_all/by_type]
References: <1376841012-7542-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1376841012-7542-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/18/2013 05:50 PM, Jonathan Cameron wrote:
> Changes since V1.
> 1) Deal with ext_info as well as the info_mask.
>     In the previous set things sort of worked by coincidence of the ordering
>     in the enum.  This version handles this cleanly.
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

Makes sense and looks good, except for that enum formating issue.
