Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58442 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab2FIQ4c (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jun 2012 12:56:32 -0400
Message-ID: <4FD38E5E.20005@kernel.org>
Date: Sat, 09 Jun 2012 18:56:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio: Add support for multiple buffers
References: <1338406594-14550-1-git-send-email-jic23@kernel.org> <1338406594-14550-2-git-send-email-jic23@kernel.org> <4FD216B2.7080504@metafoo.de> <4FD33EC3.3010505@kernel.org> <4FD33871.6080107@metafoo.de>
In-Reply-To: <4FD33871.6080107@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/09/2012 12:50 PM, Lars-Peter Clausen wrote:
> On 06/09/2012 02:17 PM, Jonathan Cameron wrote:
>>>> [...]
>>>> @@ -534,31 +453,186 @@ static int iio_compute_scan_bytes(struct ii=
o_dev *indio_dev, const long *mask,
>>>>  	return bytes;
>>>>  }
>>>> =20
>>>> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
>>>> +int iio_update_buffers(struct iio_dev *indio_dev,
>>>> +		       struct iio_buffer *insert_buffer,
>>>> +		       struct iio_buffer *remove_buffer)
>>>>  {
>>>> -	struct iio_buffer *buffer =3D indio_dev->buffer;
>>>> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
>>>> +	int ret;
>>>
>>> drivers/iio/industrialio-buffer.c: In function =91iio_update_buffer=
s=92:
>>> drivers/iio/industrialio-buffer.c:460: warning: =91ret=92 may be us=
ed
>>> uninitialized in this function
>>>
>>> I think there a missing 'return 0', before the error handling. Righ=
t now the
>>> code always sets active_scan_mask to NULL.
>> The setting to NULL definitely isn't right, but we do still need to
>> free the compoundmask.  I'll fix that up.
>=20
> Only if compoundmask !=3D active_scan_mask
indeed.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

