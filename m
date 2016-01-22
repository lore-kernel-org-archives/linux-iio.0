Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:23344 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754095AbcAVOhh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jan 2016 09:37:37 -0500
Subject: Re: [RFC 1/2] iio: core: added support for a single output that
 supports both current and voltage
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	<linux-iio@vger.kernel.org>
References: <1453467296-26356-1-git-send-email-sean.nyekjaer@prevas.dk>
 <2C284AAE-21FB-4EFE-AD1C-2F010B15C845@jic23.retrosnub.co.uk>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56A23EAD.1000207@prevas.dk>
Date: Fri, 22 Jan 2016 15:37:33 +0100
MIME-Version: 1.0
In-Reply-To: <2C284AAE-21FB-4EFE-AD1C-2F010B15C845@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

How do you register two channels for one channel?
Please give a quick example

/Sean

On 2016-01-22 15:14, Jonathan Cameron wrote:
> Hi
>
> Quick gut feel response. Register two channels.
>
> Jonathan
>
> On 22 January 2016 12:54:55 GMT+00:00, Sean Nyekjaer 
> <sean.nyekjaer@prevas.dk> wrote:
>
>     Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>     ---
>       drivers/iio/industrialio-core.c | 2 ++
>       include/linux/iio/iio.h         | 1 +
>       include/uapi/linux/iio/types.h  | 1 +
>       3 files changed, 4 insertions(+)
>
>     diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>     index fd01f34..5e1beea 100644
>     --- a/drivers/iio/industrialio-core.c
>     +++ b/drivers/iio/industrialio-core.c
>     @@ -77,6 +77,7 @@ static const char * const iio_chan_type_name_spec[] = {
>        [IIO_VELOCITY] = "velocity",
>        [IIO_CONCENTRATION] = "concentration",
>        [IIO_RESISTANCE] = "resistance",
>     + [IIO_DUAL_VOLTCUR] = "voltcur",
>       };
>       
>       static const char * const iio_modifier_names[] = {
>     @@ -146,6 +147,7 @@ static const char * const iio_chan_info_postfix[] = {
>        [IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>        [IIO_CHAN_INFO_CALIBEMISSIVITY] = "calibemissivity",
>       
>     [IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>     + [IIO_CHAN_INFO_MODE] = "mode",
>       };
>       
>       /**
>     diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>     index b589411..ef4c7cd9 100644
>     --- a/include/linux/iio/iio.h
>     +++ b/include/linux/iio/iio.h
>     @@ -46,6 +46,7 @@ enum iio_chan_info_enum {
>        IIO_CHAN_INFO_DEBOUNCE_TIME,
>        IIO_CHAN_INFO_CALIBEMISSIVITY,
>        IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>     + IIO_CHAN_INFO_MODE,
>       };
>       
>       enum iio_shared_by {
>     diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
>     index 7c63bd6..81e6a2a 100644
>     --- a/include/uapi/linux/iio/types.h
>     +++ b/include/uapi/linux/iio/types.h
>     @@ -37,6 +37,7 @@ enum iio_chan_type {
>        IIO_VELOCITY,
>        IIO_CONCENTRATION,
>        IIO_RESISTANCE,
>     + IIO_DUAL_VOLTCUR,
>       };
>       
>       enum iio_modifier {
>
>
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity. 

