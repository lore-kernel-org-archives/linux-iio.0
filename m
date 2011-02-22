Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50545 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab1BVUp0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 15:45:26 -0500
Message-ID: <4D642082.4070507@cam.ac.uk>
Date: Tue, 22 Feb 2011 20:45:54 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: Documentation: generic_buffer example: scan_size
 must be bytes_per_datum
References: <1297781180-5071-1-git-send-email-michael.hennerich@analog.com> <1297781180-5071-4-git-send-email-michael.hennerich@analog.com> <4D6404E8.1050309@cam.ac.uk> <4D641AD5.7090805@analog.com>
In-Reply-To: <4D641AD5.7090805@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/11 20:21, Michael Hennerich wrote:
> On 02/22/2011 07:48 PM, Jonathan Cameron wrote:
>> On 02/15/11 14:46, michael.hennerich@analog.com wrote:
>>   
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> In case a timestamp is present, scan size returned by size_from_channelarray()
>>> is not longer valid.
>>>     
>> Really?  Shouldn't the timestamp just be picked up as another channel assuming
>> all the relevant attributes are present (which they should be...)
>>   
> I think the pronunciation is on 'should be'.
> Looks like all my drivers don't do it, as well as some of yours.
> 
> My assumption was that bytes_per_datum must be properly set.
That should certainly be the case.  We could put a sanity check in to
test both numbers are the same as clearly we've gotten it wrong in some
drivers.
> And that the timestamp is always assumed to be the last 8bytes aligned
> on a 64-bit boundary.
It is at the moment but that might change so lets do it right now..
> I guess some drivers need fixing.
Yes. It looks that way. Good thing you picked up on this problem.
>  
>>   
>>> However size_from_channelarray() must be still called
>>> in order to setup locations within the buffer.
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>> ---
>>>  drivers/staging/iio/Documentation/generic_buffer.c |    8 +++++++-
>>>  1 files changed, 7 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
>>> index 131d9d0..c382452 100644
>>> --- a/drivers/staging/iio/Documentation/generic_buffer.c
>>> +++ b/drivers/staging/iio/Documentation/generic_buffer.c
>>> @@ -226,7 +226,13 @@ int main(int argc, char **argv)
>>>       ret = write_sysfs_int("enable", buf_dir_name, 1);
>>>       if (ret < 0)
>>>               goto error_free_buf_dir_name;
>>> -     scan_size = size_from_channelarray(infoarray, num_channels);
>>> +
>>> +     scan_size = read_sysfs_posint("bytes_per_datum", buf_dir_name);
>>> +     if (ret < 0)
>>> +             goto error_free_buf_dir_name;
>>> +
>>> +     size_from_channelarray(infoarray, num_channels);
>>> +
>>>       data = malloc(scan_size*buf_len);
>>>       if (!data) {
>>>               ret = -ENOMEM;
>>>     
>>   
> 
> 

