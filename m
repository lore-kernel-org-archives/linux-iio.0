Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay03-haj2.antispameurope.com ([83.246.65.53]:60982 "EHLO
	relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751989Ab0IBHYc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2010 03:24:32 -0400
Message-ID: <4C7F512B.1000800@iis.fraunhofer.de>
Date: Thu, 02 Sep 2010 09:24:27 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: Andrew Chew <AChew@nvidia.com>
CC: "'linux-iio@vger.kernel.org'" <linux-iio@vger.kernel.org>
Subject: Re: IIO magnetometer attributes
References: <643E69AA4436674C8F39DCC2C05F763816B85AD08D@HQMAIL03.nvidia.com> <4C7E2DB6.9090104@cam.ac.uk> <643E69AA4436674C8F39DCC2C05F763816B85AD094@HQMAIL03.nvidia.com>
In-Reply-To: <643E69AA4436674C8F39DCC2C05F763816B85AD094@HQMAIL03.nvidia.com>
Content-Type: multipart/mixed;
 boundary="------------050407070100020507030703"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------050407070100020507030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id JAA00901

Am 01.09.2010 23:25, schrieb Andrew Chew:
>> The documentation had slipped until a large set of patches
>> from Manuel Stahl
>> that Greg KH pulled into staging this morning.  Hopefully the
>> code and docs
>> now match rather better!
>
> Where's the repository that you're talking about, that has this updated=
 documentation?  I did a pull of the kernel.org .35 git, as well as kerne=
l.org's mainline, and don't see any updates to this documentation.

In linux-next of course:
http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dhisto=
ry;f=3Ddrivers/staging/iio;hb=3DHEAD

The patches are also sent to linux-iio@vger.kernel.org

Regards,
--=20
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f=FCr Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N=FCrnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl@iis.fraunhofer.de

--------------050407070100020507030703
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


--------------050407070100020507030703--
