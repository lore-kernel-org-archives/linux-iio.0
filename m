Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47684 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbbHOPSz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 11:18:55 -0400
Subject: Re: [PATCH v2] iio: generic_buffer: be helpful about enabling
 channels
To: Hartmut Knaack <knaack.h@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
References: <1439196908-5627-1-git-send-email-linus.walleij@linaro.org>
 <55CA3D04.6050005@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF585D.9080408@kernel.org>
Date: Sat, 15 Aug 2015 16:18:53 +0100
MIME-Version: 1.0
In-Reply-To: <55CA3D04.6050005@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 19:20, Hartmut Knaack wrote:
> Linus Walleij schrieb am 10.08.2015 um 10:55:
>> Currently if generic_buffer is invoked without first enabling any
>> channels in scan_elements/*_en, it will fail unable to enable the
>> buffer because bytes_per_datum inside the kernel will be zero if
>> no channels are available.
>>
>> It is implied that the user of the program should enable channels
>> manually or with a script before executing generic_buffer.
>>
>> Be more helpful by stopping execution if no enabled channels can
>> be found, and print a helptext that will tell you what is wrong
>> and what needs to be done.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.  Thanks for clearing this up.

Jonathan
>> ---
>> ChangeLog v1->v2:
>> - Rebased on the "togreg" branch
>> - Print errors to stderr as requested by Hartmut
>> ---
>>  tools/iio/generic_buffer.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
>> index 9f7b85bf6ada..01c4f67801e0 100644
>> --- a/tools/iio/generic_buffer.c
>> +++ b/tools/iio/generic_buffer.c
>> @@ -328,6 +328,15 @@ int main(int argc, char **argv)
>>  			"diag %s\n", dev_dir_name);
>>  		goto error_free_triggername;
>>  	}
>> +	if (!num_channels) {
>> +		fprintf(stderr,
>> +			"No channels are enabled, we have nothing to scan.\n");
>> +		fprintf(stderr, "Enable channels manually in "
>> +			FORMAT_SCAN_ELEMENTS_DIR
>> +			"/*_en and try again.\n", dev_dir_name);
>> +		ret = -ENOENT;
>> +		goto error_free_triggername;
>> +	}
>>  
>>  	/*
>>  	 * Construct the directory name for the associated buffer.
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

