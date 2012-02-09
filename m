Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:36039 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754136Ab2BITGY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Feb 2012 14:06:24 -0500
Message-ID: <4F341926.5090902@metafoo.de>
Date: Thu, 09 Feb 2012 20:06:14 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jonathan Cameron <jic23@kernel.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/6] staging:iio: Update iio_event_interface documentation
References: <1328131074-2739-1-git-send-email-lars@metafoo.de> <1328131074-2739-2-git-send-email-lars@metafoo.de> <20120209181240.GA1340@kroah.com>
In-Reply-To: <20120209181240.GA1340@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2012 07:12 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 01, 2012 at 10:17:49PM +0100, Lars-Peter Clausen wrote:
>> The documentation for the iio_event_interface does not match the actual struct
>> anymore. This patch removes the documentation for non-existing fields and adds
>> documentation for missing fields.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/staging/iio/industrialio-core.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> This patch fails to apply to my tree, possibly because of your other
> patches I accepted.
> 
> Care to redo this series against the next linux-next release and resend?
> 

You've applied v1 of the series, but the diffwas only a minor documentation fix
anyway, so I'll sent it as an individual patch.

Thanks,
- Lars
