Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613643;
	b=vCwmdX8ee7jsilvzu9heLk1P6sra9YE2XPRgwWbDnn5+meLxRUWEd2r1GPzXdgVcIyiI
	 HZj7vxEtttvKe68GV9hQlTbsYa+v4wZV3IP7AYr47TX+OhZa7PPoqOkI2gDIA1haAUGFe
	 KInUhZNxhB0CitVeG+WU9hUF+YUfzazROv5iulbNc0uVgzVIKgI0nXkBvTOwhRSvDh2/F
	 yVobX/r8yEeWAk2sFUB8QcR+14QEpYFmvctZDSIUVPFqeHpxiDHWK1IT9mAZXyQmYFFMn
	 Ugwwl1Yb2RHNrLACMLX0awij9lTGGOMM/FjKXxGIfoZIr1vRdj/zQxd/dpCR+XrkV0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613643;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-FEAS-BEC-Info:X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:
	 X-FE-Policy-ID:X-FE-Hostname:DKIM-Signature;
	bh=IQRSUatpW3QIw0hMPvt6k5IgX74QBf/y1Lggcs8VUOY=;
	b=hgwcSsl3eD51zDJVsEFRzcJS4fpWp/BGD7km1BV6HyqNLPZqOOsTD7j7t8hC05F+bf94
	 vj86VXumWgRj4LHsodb/vHustpPCIeBBIzz/ub4hryeAaH/28Rgqobedqr0Uox8NB12M1
	 vJrxFJYyS88/s7N9iREKYOHR9J6BphLltVFxDi8Rv/x5/asanQkluo36ycOmtjOZlo4L2
	 HxcYg/Louf3OzL0Rn3y6AiMTR6pnISflSMQD9VXkblLVN0E9ImX7iCGFf6xLevjtLYr8z
	 /YIZNdtgz+z++eVuGeTwaK8SinaFb7GU5gRNqVgepy9+43FWmS5wOi3nSEoiNeunNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=e3OserD4;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79192606A32E;
	Mon,  2 Nov 2026 10:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79192606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=e3OserD4
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A2A0JBW025867-6A2A0JBY025867
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 2 Nov 2026 12:00:19 +0200
Received: from ex19-13.utu.fi ([130.232.247.53])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <jaakko.ma.koivisto@utu.fi>)
	id 1xNopu-00GotW-Tv;
	Mon, 02 Nov 2026 12:00:18 +0200
Received: from ex19-16.utu.fi (130.232.247.56) by ex19-13.utu.fi
 (130.232.247.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 12:00:18 +0200
Received: from ex19-16.utu.fi ([fe80::7a30:a297:cbf9:5593]) by ex19-16.utu.fi
 ([fe80::7a30:a297:cbf9:5593%3]) with mapi id 15.02.2562.056; Mon, 2 Nov 2026
 12:00:18 +0200
From: Jaakko Koivisto <jaakko.ma.koivisto@utu.fi>
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: VS: [PATCH v2 5/5] iio: chemical: sgp40: Implement
 turn_heater_off-command
Thread-Topic: [PATCH v2 5/5] iio: chemical: sgp40: Implement
 turn_heater_off-command
Thread-Index: AQHdaqq2B+S4MSM1PkS14QPwPuY8qbcajF61
Date: Mon, 2 Nov 2026 10:00:18 +0000
Message-ID: <cfb5be27fdef499680baa48b82813cd4@utu.fi>
References: <20261102091509.252337-1-jmatko@utu.fi>
In-Reply-To: <20261102091509.252337-1-jmatko@utu.fi>
Accept-Language: fi-FI, en-US
Content-Language: fi-FI
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFpdSAIJCQMDB0YFCUYDBwEeARscBygdHB1GDgFIWUhZXkgJAygB
 HEUDBAEGDw0aRgwNSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFleSAkDKAEcRQMEAQYPDRpGDA1IWEhZXUgJBgwRKAMNGgYNBEYHGg9IWEhaWUgM
 BA0LAAYNGigKCREEAQoaDUYLBwVIWEhaXUgEAQYdEEUBAQcoHg8NGkYDDRoGDQRGBxoPSFhIWVBIBh0GB0YbCSgJBgkEBw9GCwcFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:content-type:mime-version;
 bh=IQRSUatpW3QIw0hMPvt6k5IgX74QBf/y1Lggcs8VUOY=;
 b=e3OserD4NCg+queVQOb4Ps8rHTvbrlP+QWZoSsJ7loWczMcvNEh46JZHb18R+j4HBflH4HnGb36K
	8O5RfrwX2NY/EqQp6BnO+cO+QqBCYw31OYhggqXDsOBWRgwGz6HYbZBCOpFhxnfqak4OAfbP8PTI
	yw647dgzOCStt9JP8emw9tNQrFqra4HMG2MdsF7ZKXAVqnvijQNEN+D/dC9latDzstRYmGiPPsLa
	QSgPeld9d03GRjdRliIcGsxEacGH1+20CTKss4kjq7H8Ot0gxW5pUSb8HPgMkAAOtdTeDspG3G4C
	Vo9Pxi8ljjlGZpwbIy7IKXWEZ6jV5Ube7Z25Dg==

Mail failure, disregard. Superseded by the properly threaded copy.
________________________________________
L=E4hett=E4j=E4: Jaakko Koivisto
L=E4hetetty: maanantai 2. marraskuuta 2026 11.15.09
Vastaanottaja: Andreas Klinger; Jonathan Cameron; David Lechner; Nuno S=E1;=
 Andy Shevchenko
Kopio: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Jaakko Koiv=
isto
Aihe: [PATCH v2 5/5] iio: chemical: sgp40: Implement turn_heater_off-comman=
d

Add functionality for turning the SGP40 sensor heating element
on or off manually. After turning the heater off, the sensor enters
idle mode. Track the state of the heater in the driver, as the device
does not expose current heater state via any register.

Turning the heater off saves approx. 2.5 mA compared to regular
operation. The heating element is automatically turned back on
when measurement is performed.

Signed-off-by: Jaakko Koivisto <jmatko@utu.fi>
---
 drivers/iio/chemical/sgp40.c | 62 +++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index 278390bc6b04..87df8d79fe6e 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -54,7 +54,8 @@ struct sgp40_data {
        int                     rht;
        int                     temp;
        int                     res_calibbias;
-       /* Prevent concurrent access to rht, tmp, calibbias */
+       bool                    heater_enabled;
+       /* Prevent concurrent access to rht, tmp, calibbias, heater_enabled=
 */
        struct mutex            lock;
 };

@@ -263,6 +264,27 @@ static int sgp40_execute_self_test(struct sgp40_data *=
data)
        }
 }

+static int sgp40_turn_heater_off(struct sgp40_data *data)
+{
+       int ret;
+       struct i2c_client *client =3D data->client;
+       struct sgp40_tg_measure turn_off =3D { .command =3D {0x36, 0x15} };
+
+       guard(mutex)(&data->lock);
+
+       ret =3D i2c_master_send(client, (char *)&turn_off, sizeof(turn_off.=
command));
+       if (ret < 0)
+               return ret;
+       if (ret !=3D sizeof(turn_off.command))
+               return dev_err_probe(data->dev, -EIO,
+                      "i2c_master_send ret: %d, expected %zu", ret, sizeof=
(turn_off.command));
+
+       fsleep(1000); /* Max duration for command turn_heater_off. Datashee=
t table 8. */
+       data->heater_enabled =3D false;
+
+       return 0;
+}
+
 static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resi=
stance_raw)
 {
        int ret;
@@ -293,6 +315,7 @@ static int sgp40_measure_resistance_raw(struct sgp40_da=
ta *data, u16 *resistance
                return -EIO;
        }
        msleep(30);
+       data->heater_enabled =3D true;

        ret =3D i2c_master_recv(client, (u8 *)&tgres, sizeof(tgres));
        if (ret < 0)
@@ -423,10 +446,47 @@ static ssize_t serialnumber_show(struct device *dev,
        return sysfs_emit_at(buf, 0, "%llu\n", serial_number);
 }

+static ssize_t heater_enable_store(struct device *dev,
+                                  struct device_attribute *attr,
+                                  const char *buf, size_t len)
+{
+       int ret;
+       u16 __ignore;
+       bool val;
+       struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
+
+       ret =3D kstrtobool(buf, &val);
+       if (ret)
+               return ret;
+
+       if (val)
+               ret =3D sgp40_measure_resistance_raw(data, &__ignore);
+       else
+               ret =3D sgp40_turn_heater_off(data);
+
+       if (ret)
+               return ret;
+
+       return len;
+}
+
+static ssize_t heater_enable_show(struct device *dev,
+                                 struct device_attribute *attr,
+                                 char *buf)
+{
+       struct sgp40_data *data =3D iio_priv(dev_to_iio_dev(dev));
+
+       guard(mutex)(&data->lock);
+
+       return sysfs_emit(buf, "%d\n", data->heater_enabled);
+}
+
 static IIO_DEVICE_ATTR_RO(serialnumber, 0);
+static IIO_DEVICE_ATTR_RW(heater_enable, 0);

 static struct attribute *sgp40_attributes[] =3D {
        &iio_dev_attr_serialnumber.dev_attr.attr,
+       &iio_dev_attr_heater_enable.dev_attr.attr,
        NULL
 };

--
2.56.0

