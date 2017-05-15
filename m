Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:43461 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933275AbdEOJSw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 May 2017 05:18:52 -0400
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
To: Maxime Ripard <maxime.ripard@free-electrons.com>
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
 <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, wens@csie.org, clabbe.montjoie@gmail.com,
        linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <73eb7674-dba9-8bdf-c886-6ad8177f4c1b@free-electrons.com>
Date: Mon, 15 May 2017 11:18:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TeRqv2tmm3gAI9sNQ7PRoLuJL6AsrBR7X"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TeRqv2tmm3gAI9sNQ7PRoLuJL6AsrBR7X
Content-Type: multipart/mixed; boundary="P2VtRxInpAqMMR5dj74g4QpxEKuM0d5rB";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 wens@csie.org, clabbe.montjoie@gmail.com, linux-iio@vger.kernel.org,
 thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <73eb7674-dba9-8bdf-c886-6ad8177f4c1b@free-electrons.com>
Subject: Re: [PATCH] iio: adc: sun4i-gpadc-iio: fix parent device being used
 in devm function
References: <20170515073902.25994-1-quentin.schulz@free-electrons.com>
 <20170515091148.gk2zvtjy5bdpbfzt@flea.home>
In-Reply-To: <20170515091148.gk2zvtjy5bdpbfzt@flea.home>

--P2VtRxInpAqMMR5dj74g4QpxEKuM0d5rB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 15/05/2017 11:11, Maxime Ripard wrote:
> On Mon, May 15, 2017 at 09:39:02AM +0200, Quentin Schulz wrote:
>> For the sake of DT binding stability, this IIO driver is a child of an=

>> MFD driver for Allwinner A10, A13 and A31 because there already exists=
 a
>> DT binding for this IP. The MFD driver has a DT node but the IIO drive=
r
>> does not.
>>
>> The IIO device registers the temperature sensor in the thermal framewo=
rk
>> using the DT node of the parent, the MFD device, so the thermal
>> framework could match the phandle to the MFD device in the DT and the
>> struct device used to register in the thermal framework.
>>
>> devm_thermal_zone_of_sensor_register was previously used to register t=
he
>> thermal sensor with the parent struct device of the IIO device,
>> representing the MFD device. By doing so, we registered actually the
>> parent in the devm routine and not the actual IIO device.
>>
>> This lead to the devm unregister function not being called when the II=
O
>> module driver is removed. It resulted in the thermal framework still
>> polling the get_temp function of the IIO module while the device doesn=
't
>> exist anymore, thus generated a kernel panic.
>>
>> Use the non-devm function instead and do the unregister manually in th=
e
>> remove function.
>>
>> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>
>> ---
[...]
>> @@ -688,6 +687,12 @@ static int sun4i_gpadc_remove(struct platform_dev=
ice *pdev)
>> =20
>>  	pm_runtime_put(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>> +
>> +	if (pdev->dev.of_node)
>> +		thermal_zone_of_sensor_unregister(&pdev->dev, info->tzd);
>> +	else
>> +		thermal_zone_of_sensor_unregister(pdev->dev.parent, info->tzd);
>> +
>=20
> Can't we just store the device used to create the zone in the
> structure as well, that would avoid that non-trivial logic.
>=20

Yes we could.

I've that same condition in the probe function, if pdev->dev.of_node
then I continue in the probe dedicated to device probed from DT, or I
continue with the probe dedicated to device probed via MFD.

The thermal_zone_of_sensor_register is different in those two functions,
thus, I thought that it would make more sense to replicate the same
condition in the remove to make the relation between the device used in
thermal_zone_of_sensor_register and unregister clear.

That's just a matter of taste for me, so I'm definitely ok to write a v2
for this change.

Thanks,
Quentin

--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--P2VtRxInpAqMMR5dj74g4QpxEKuM0d5rB--

--TeRqv2tmm3gAI9sNQ7PRoLuJL6AsrBR7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJZGXJ6AAoJEIS4mnU+4PGjoRoQALTQbCXph5QWKbJojRFNtEGB
t7d+1ivLpaMG+V4shr3HApkobeXq4lILrohEOrG88RbcWeTrRFWz6vjjshFtmjtr
Ji0B4XLy+cyM51Ky/WI+p0WpqD+8iLM1VxrSh4yU9VDdrJzl3qpOhqKa4mQUXe9p
qoKBI3cXmuSRo2QblQ1tT5qh/n1MnuhM2XQCMHRCxdYRVQPVw1kmMqHlm+Ciu62F
CEn12y7xbGg0LPJHMd1gxZyX0FIV2ORVLynSXuHqPA0CqJGmNBPz13kAOxjCisPt
3IXcbVLVF9E12GZ2uKt/GVr5W9RiangCh0GhJvxeJ5UB0vyTHrfzC55+3uSoalZd
LYJrvUjKJUaH60SO+3ipOed9o0lyfGFS9/UuJkSi5hTl4SNhzenzrGIf3QNY3ftk
xcWFnZTrHV3KAUfJjv0wXFAluWu9lefn79nUjh182tm+Lu9jHXKVdEV0v3LPoMZC
IPX0q5qmULRQIvVGgsxVYisU2sf8e87QwSM3r5Cpn5yIxtkvGQMi1qldm416ARx1
z6jFK46ojBRu2aldu/PIi8Vk5pNGm5LmsDt0EdLFB0U7XJ8COdKE56OfoEY6dXfE
Nu5+84Qc0c18w1fjLQ9bbGwZKJ0jHxx+4z9oJnxfya182D2/qiAKZGnTXhIE7iDr
GavQ7kx8LmalP/AyFZrd
=XFps
-----END PGP SIGNATURE-----

--TeRqv2tmm3gAI9sNQ7PRoLuJL6AsrBR7X--
