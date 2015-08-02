Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45776 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbHBSfy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:35:54 -0400
Subject: Re: [PATCH v2 2/2] iio: magnetometer: add mmc34160 magnetometer
 driver
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <1437400350-25960-1-git-send-email-teodora.baluta@intel.com>
 <1437400350-25960-3-git-send-email-teodora.baluta@intel.com>
 <20150720141424.GJ5422@mwanda> <55BE461E.9000200@kernel.org>
 <20150802163727.GR5096@mwanda>
Cc: Teodora Baluta <teodora.baluta@intel.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE6307.3080806@kernel.org>
Date: Sun, 2 Aug 2015 19:35:51 +0100
MIME-Version: 1.0
In-Reply-To: <20150802163727.GR5096@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/08/15 17:37, Dan Carpenter wrote:
> On Sun, Aug 02, 2015 at 05:32:30PM +0100, Jonathan Cameron wrote:
>> On 20/07/15 15:14, Dan Carpenter wrote:
>>> On Mon, Jul 20, 2015 at 04:52:30PM +0300, Teodora Baluta wrote:
>>>> +static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo,
>>>> +				  int index, int *val)
>>>> +{
>>>> +	switch (index) {
>>>> +	case AXIS_X:
>>>> +		*val = (raw[AXIS_X] - nfo) * 1000 / sens[AXIS_X];
>>>> +		break;
>>>> +	case AXIS_Y:
>>>> +		*val = (raw[AXIS_Y] - nfo) * 1000 / sens[AXIS_Y];
>>>> +		break;
>>>> +	case AXIS_Z:
>>>> +		*val = (raw[AXIS_Z] - nfo) * 1000 / sens[AXIS_Z];
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> We never pass invalid indexes here so this could be replaced with:
>>>
>>> static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo,
>>> 				  int index, int *val)
>>> {
>>> 	*val = (raw[index] - nfo) * 1000 / sens[index];
>>> 	return 0;
>> Even better change the function signature and don't return anything at 
>> all perhaps?
>>
> 
> Yeah.  Or this:
> 
> static int mmc34160_raw_to_mgauss(int raw[3], int sens[3], int nfo, int index)
> {
> 	return (raw[index] - nfo) * 1000 / sens[index];
> }
> 
> regards,
> dan carpenter
*laughs*. Good point ;)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

