Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:48458 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab0H3QoF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 12:44:05 -0400
Message-ID: <4C7BE0F4.30004@cam.ac.uk>
Date: Mon, 30 Aug 2010 17:48:52 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging:iio move scan_elements into ring buffer
References: <4C77D52A.6090606@cam.ac.uk> <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BAAF1.7050501@cam.ac.uk> <4C7BB41C.7000907@iis.fraunhofer.de> <4C7BD886.3060109@cam.ac.uk> <4C7BDCFF.7070305@iis.fraunhofer.de>
In-Reply-To: <4C7BDCFF.7070305@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/30/10 17:31, Manuel Stahl wrote:
> Am 30.08.2010 18:12, schrieb Jonathan Cameron:
>> On 08/30/10 14:37, Manuel Stahl wrote:
>>> Am 30.08.2010 14:58, schrieb Jonathan Cameron:
>>>> On 08/30/10 11:55, Manuel Stahl wrote:
>>>>> Signed-off-by: Manuel Stahl<manuel.stahl@iis.fraunhofer.de>
>>>>
>>>> On more complex patches like this, could you verify which devices
>>>> you have tested against? Given the nature of that patch it
>>>> probably doesn't matter that much, but it's nice to save people
>>>> from wondering if they need to test on devices you have already
>>>> tried it with.
>>>
>>> I have an sca3000 and an adis16405 to test with. The patch was made against v26.36-rc2 and compiled fine for all drivers in staging.
>> Glad you have an sca3000.  My test board is currently broken so I've just
>> been crossing my fingers that I hadn't broken the driver with recent code
>> changes!  Have you had any problems with the adis16405?  I'm currently getting
>> seg faults with an adis16350 that I can't seem to track down.  I'm waiting
>> for Barry to answer a few queries on that one...
> 
> I know where the segfaults come from: iio_scan_el_show, etc.
> I forgot to cast to a buffer instead of a iio_dev.
Nope, the problem was pre todays patches, though obviously please fix
that one ;)  That kit is at home so I'll give it another poke this evening.
> 
> For sca3000 I have some problems with the ring buffer. The event doesn't get triggered.
Guess I should fix my board and take another look at that driver.

Jonathan

