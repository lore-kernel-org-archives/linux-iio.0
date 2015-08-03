Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34939 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194AbbHCKpz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2015 06:45:55 -0400
MIME-Version: 1.0
In-Reply-To: <55BE7395.1090503@gmx.de>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
	<b36f8de1969bd0650e07bbac57d7120d700a8d32.1437737942.git.cristina.opriceana@gmail.com>
	<55BE52F6.7020608@kernel.org>
	<55BE7031.5090009@gmx.de>
	<55BE7395.1090503@gmx.de>
Date: Mon, 3 Aug 2015 13:45:54 +0300
Message-ID: <CAFA9rWMPpU3j4dYAQrofFL0PmTmKuOe28itQAMiuezrFc6k4=g@mail.gmail.com>
Subject: Re: [PATCH 2/6] iio: buffer: Fix kernel docs warnings
From: Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 2, 2015 at 10:46 PM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Hartmut Knaack schrieb am 02.08.2015 um 21:32:
>> Jonathan Cameron schrieb am 02.08.2015 um 19:27:
>>> On 24/07/15 14:18, Cristina Opriceana wrote:
>>>> Fix kernel docs for structures and functions in order to
>>>> remove some warnings when the documentation gets generated.
>>>>
>>>> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
>>> Applied with another typo fixed up.
>>
>> Hi,
>> I'm afraid there is some information missing.
>>
>>>> ---
>>>>  drivers/iio/industrialio-buffer.c | 15 ++++++++++++++-
>>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>>>> index b13f941..a671953 100644
>>>> --- a/drivers/iio/industrialio-buffer.c
>>>> +++ b/drivers/iio/industrialio-buffer.c
>>>> @@ -91,9 +91,16 @@ static bool iio_buffer_ready(struct iio_dev *indio_dev, struct iio_buffer *buf,
>>>>
>>>>  /**
>>>>   * iio_buffer_read_first_n_outer() - chrdev read for buffer access
>>>> + * @filp:  File structure pointer for the char device
>>>> + * @buf:   Destination buffer for iio buffer read
>>>> + * @n:             First n bytes to read
>>>> + * @f_ps:  Long offset provided by the user as a seek position
>>>>   *
>>>>   * This function relies on all buffer implementations having an
>>>>   * iio_buffer as their first element.
>>>> + *
>>>> + * Return: negative values corresponding to error codes or ret != 0
>>>> + *    for ending the reading activity
>>
>> This may also return 0. Would it be wrong to state that if the return
>> value is not negative, then it will indicate the amount of data read?
>>
>>>>   **/
>>>>  ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>>>                                   size_t n, loff_t *f_ps)
>>>> @@ -143,6 +150,12 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>>>>
>>>>  /**
>>>>   * iio_buffer_poll() - poll the buffer to find out if it has data
>>>> + * @filp:  File structure poiner for device access
>>> pointer
>>>> + * @wait:  Poll table structure pointer for which the driver adds
>>>> + *         a wait queue
>>>> + *
>>>> + * Return: (POLLIN | POLLRDNORM) if data is available for reading
>>>> + *    or 0 for other cases
>>
>> This can also return -ENODEV.
>
> On second thought however, it may return anything, given it is unsigned int.
> Any volunteers?
>
I sent a patch changing the return value in case that no device is bound

Cristina
>>
>>>>   */
>>>>  unsigned int iio_buffer_poll(struct file *filp,
>>>>                          struct poll_table_struct *wait)
>>>> @@ -1136,7 +1149,7 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
>>>>  EXPORT_SYMBOL_GPL(iio_scan_mask_query);
>>>>
>>>>  /**
>>>> - * struct iio_demux_table() - table describing demux memcpy ops
>>>> + * struct iio_demux_table - table describing demux memcpy ops
>>>>   * @from:  index to copy from
>>>>   * @to:            index to copy to
>>>>   * @length:        how many bytes to copy
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
