Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4C7BDCFF.7070305@iis.fraunhofer.de>
Date: Mon, 30 Aug 2010 18:31:59 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] staging:iio move scan_elements into ring buffer
References: <4C77D52A.6090606@cam.ac.uk> <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <4C7BAAF1.7050501@cam.ac.uk> <4C7BB41C.7000907@iis.fraunhofer.de> <4C7BD886.3060109@cam.ac.uk>
In-Reply-To: <4C7BD886.3060109@cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------090403010708020008020006"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090403010708020008020006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id SAA14637

Am 30.08.2010 18:12, schrieb Jonathan Cameron:
> On 08/30/10 14:37, Manuel Stahl wrote:
>> Am 30.08.2010 14:58, schrieb Jonathan Cameron:
>>> On 08/30/10 11:55, Manuel Stahl wrote:
>>>> Signed-off-by: Manuel Stahl<manuel.stahl@iis.fraunhofer.de>
>>>
>>> On more complex patches like this, could you verify which devices
>>> you have tested against? Given the nature of that patch it
>>> probably doesn't matter that much, but it's nice to save people
>>> from wondering if they need to test on devices you have already
>>> tried it with.
>>
>> I have an sca3000 and an adis16405 to test with. The patch was made ag=
ainst v26.36-rc2 and compiled fine for all drivers in staging.
> Glad you have an sca3000.  My test board is currently broken so I've ju=
st
> been crossing my fingers that I hadn't broken the driver with recent co=
de
> changes!  Have you had any problems with the adis16405?  I'm currently =
getting
> seg faults with an adis16350 that I can't seem to track down.  I'm wait=
ing
> for Barry to answer a few queries on that one...

I know where the segfaults come from: iio_scan_el_show, etc.
I forgot to cast to a buffer instead of a iio_dev.

For sca3000 I have some problems with the ring buffer. The event doesn't=20
get triggered.

Regards,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------090403010708020008020006
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: 7bit

begin:vcard
fn:Manuel Stahl
n:Stahl;Manuel
email;internet:manuel.stahl@iis.fraunhofer.de
tel;work:+49 911 58061-6419
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------090403010708020008020006--
