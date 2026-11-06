Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793952373;
	b=1CrxWsLM+IOpi1rZd4gXXTy0OmZ3OnyWsmVH+8owA8diRMsc6cGyjg5upIiaTYu0agzw
	 1b3aiwk7OcmWWTGcRpbA19g2b2Qvqf1zpJYPO3z6K8aCN3UdrY/bORwVGg4BcZMRfg1rD
	 rUPOYtH+WIjNeMlJTaAKGCSrYnni3+1vhJZoMXEFOEoa+KU/yeseeVxMWmK015bGaS7Nn
	 InQ5I8uzmDb9WIs9sT063xsKfaW/H+Hm2pFWTbGq0uCjXYK9oOIy6Eik10V+GqUBIKwXh
	 5/Dtg7OquFNp6IQfOV01fTdm+pD1nejwG35qo9hUQI0S/M8In86G0gpmHJ3o/7zSXoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952373;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=Q9BVJ84/wTutORsDRLBjhp7nynNi3hfQdIrA85jn/d8=;
	b=Uf8T6fSeU+swZNFxdsesV5VKShhHR0CfEW7JuLXW0AHRLKV7QgC+QG2vwum0vRCb69Gu
	 feq0dbOEBXbgYUS0Sw7h0ZzEKcPu8O4IZLnDxNvGsHbA90wohuczW4F0GwxmyBWn2/WmN
	 NhcafGsXTpwiXbn1TbnXWa4Haq2uaNcY7CkT6MZKe0rrhAgNVP4MzphI59RcHjdIyU7oi
	 CcEnEH1vcdfYjOjuCrIIMtWTT3F6VRi0oWQEqcvqCjlNC3ZfceyH3QPEiaNGsWbBJ0/Wf
	 ABD4Jmfrq95ugrVjv2k72bq6JoINFg1alLJMiUBE5o9hYX44vMrdy5nzIqRTAMfZJbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goldelico.com;
	spf=pass smtp.mailfrom=goldelico.com;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sE2jP9xe;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6cctkpTl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.167
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C202606A328;
	Fri,  6 Nov 2026 08:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C202606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goldelico.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=sE2jP9xe;
	dkim=pass header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6cctkpTl
ARC-Seal: i=1; a=rsa-sha256; t=1793952361; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sYPicSz9K+OA/ttfGobpS0AoBgQttoWnSmhUl/ruaP30eeI3N33dgehgVdyz85lZCB
    iSkooThFjI0f+t2X/9jfUs9QFg6kXmDt99qnGp/yKOFxlgNBSKPTJUdUXqTls/Z9fVRh
    oO79YIljDJUOlcUwKDUhLpMgHaFR6aVlHyehyVIam4c9xnbL1AIEnu57/Tt2ll+W+g81
    wza9ckIZQ7wErERSZeYR6ZTO0XbJvjpnO8tjDmtRvmuJso6LFdzjbcepb0OTqAe/ApuL
    DKhXZR8bsxT4FyxZqN/Fip7Eo1OqXzH5zyrFsGRyIyXiBW6bG2IabPbtim6baBE2rFu9
    jzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793952361;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Q9BVJ84/wTutORsDRLBjhp7nynNi3hfQdIrA85jn/d8=;
    b=jL5N1kXaE+PfEwf6+uV+nDvYbvkBIUYAZtK8qMmmryIHSAnlXVr0sCJTGQDh/amV3k
    GeKaNkMTel8RbUDaGoNeEOuRutPwQPTBDGZsu/nyzJAnGytC+K0Ibr78V5UlX7ltO9sG
    gBsOXCS28egFtzp7OTCaRYBfoU1I3QbEbyq7ugFxfDPNy6kHKX2LuHWANOuFzjeAMSV/
    zxTruoGYFxD8aiJLtpT0C/8lIjbx79T/uOMsY3aQoQUdIUPTOMASfHNm2bK+iRv8ScYL
    Sn2uJJKKXtvHgqq8aXQjyFBtvj2LFN1JvPI6r+2O8GTaJa8lGbFHB3jxFJk49+kHLDq/
    FyZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793952361;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Q9BVJ84/wTutORsDRLBjhp7nynNi3hfQdIrA85jn/d8=;
    b=sE2jP9xeJsULXj9aKh0HwJnVmTcRgTnsndfxQziunyBKz4r+QheVv+ap0s53mKh2pi
    UPTvxdDSYar2xNwx1nAeYkJaixJkKeLaKoYsHruUZGAUJERhsuv+kFyc9bVO+DFInf1h
    Emo/MM/TUzRMCGuX1hODbKk+LXqYEQ2EZDwIqk65yaBTvPBSDLwwS2bXchUcmwd/4d/5
    izc+GtWwXPswjrHakKRet5Y/43HjGf9S20U2o0XMub1I7qtN+uw3/rD9uXsiBlZCzKd9
    SL8UOrKa7bBeANWe7ig1N6C6hMwXSAiFwA6C+hvm9Ri9FVaMNMuxTYkBoAgM8tTUEiDR
    bHpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793952361;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Q9BVJ84/wTutORsDRLBjhp7nynNi3hfQdIrA85jn/d8=;
    b=6cctkpTlM25k1sncn87ujd1S8oyDryVRM6l9cdF+xw4pQ3PU7sZfAnBK/lNdOCf2wu
    Z/OtxKu9hcNY0r/jgQDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrVjZoMy8iN4frnsPsBQ4l+mfK4O7kvgww6TmAq"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Qb56a22A6861lr0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Fri, 6 Nov 2026 09:06:01 +0100 (CET)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <49e69d9c-6cb1-453f-bbf5-e2202f97e4ef@kernel.org>
Date: Fri, 6 Nov 2026 09:05:30 +0100
Cc: Olivier Louvignes <olivier@mgcrea.io>,
 Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>,
 Joshua Crofts <crofts@kernel.org>,
 linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <30B040B3-D371-443C-A66D-11EF89FC7C63@goldelico.com>
References: <20261105213210.87457-1-olivier@mgcrea.io>
 <20261105213210.87457-2-olivier@mgcrea.io>
 <49e69d9c-6cb1-453f-bbf5-e2202f97e4ef@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81.1.10)



> Am 06.11.2026 um 08:05 schrieb Krzysztof Kozlowski <krzk@kernel.org>:
>=20
> On 05/11/2026 22:32, Olivier Louvignes wrote:
>> The X1600's SAR ADC has four auxiliary channels and none of the
>> touchscreen or battery engines of the JZ47xx ADCs in =
ingenic,adc.yaml,
>> so it gets a binding of its own.
>>=20
>> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
>> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - driver =
only, no real world test
>=20
> Drop, did not happen. Even comment says it did not happen!

What did not happen? Are you expecting a software test or a full =
hardware test?

>=20
> Otherwise please explain me how this code was executed on a device.

1. add decive tree entries, 2. compile, 3. install, 4. boot and load =
module, 5. check sysfs

root@letux-lx16v0-3:~# ls -l /sys/devices/platform/apb/10070000.sadc
total 0
lrwxrwxrwx 1 root root    0 Nov  6 08:00 driver -> =
../../../../bus/platform/drivers/ingenic-x1600-adc
-rw-r--r-- 1 root root 4096 Nov  6 08:00 driver_override
drwxr-xr-x 3 root root    0 Nov  6 07:58 iio:device0
-r--r--r-- 1 root root 4096 Nov  6 08:00 modalias
lrwxrwxrwx 1 root root    0 Nov  6 08:00 of_node -> =
../../../../firmware/devicetree/base/apb/sadc@10070000
drwxr-xr-x 2 root root    0 Nov  6 08:00 power
lrwxrwxrwx 1 root root    0 Nov  6 08:00 subsystem -> =
../../../../bus/platform
-rw-r--r-- 1 root root 4096 Nov  6 08:00 uevent
root@letux-lx16v0-3:~# cat =
/sys/devices/platform/apb/10070000.sadc/iio\:device0/in_voltage*
1512
1793
1796
1798
0.805664062
root@letux-lx16v0-3:~# cat =
/sys/devices/platform/apb/10070000.sadc/iio\:device0/in_voltage*
1512
1760
1766
1773
0.805664062
root@letux-lx16v0-3:~# cat =
/sys/devices/platform/apb/10070000.sadc/iio\:device0/in_voltage*
1518
1767
1767
1776
0.805664062
root@letux-lx16v0-3:~#=20

You can see that the values look reasonable and fluctuate a little by =
noise as you would
expect from an ADC with floating inputs.

But are you expecting a hardware test that the values are similar to the =
real voltages?
This is beyond my hardware capabilities.

Maybe you are more happy with:

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # LX16 - bindings =
and driver function only, no real electrical performance test

BR and have a good day,
Nikolaus=
