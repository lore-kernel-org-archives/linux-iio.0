Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197405;
	b=EZ5eBbwoQK8bEEDHMtinV5iC0pY0VrF4uJ/p+GMNOt9i6kgtyS717k9/6oSIyKPk7YNu
	 LLdqwAeVeMCB+VdAolLHrqjOReJHHqSj+Y9CQr5Gh4sQjwoV6xxHSAuwN90rQgJj9VyTG
	 nEg6nQ5NQ4MMLitufN2pUJog6NOhveagzQvMLRWplRzfbm6u3+Ea44CbNXOrAxzujVRJV
	 ZWWMD2NKIiL08i68h0/SsqRjQBPdGzgTrxKIEVz++KLPLvCoxAZw+0x81296YtrhmVOk7
	 KMPQoeuJ4Ft5aqpjFIR5hP/inW4JWl41o9/vhIYB17gl6hipJQvqCCWZ/5TbTpco+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197405;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Pg9666G5Fepn0j6xEDe4AVqUWpZEKAdFiyuWsb8Kojw=;
	b=rGe8lYQkPhYFHub0yHsX4jEjOTBbJlaV60KDMewj9BRkQAkPAu1xpBqvs++NwV7Saj9K
	 p5AsRGh3ONvqdBaJ6BYUNVx1l48iKyg1EOH+JXAg/xV+SpUUCBNt6RbrdnujmL9EXGRwS
	 LD0YlA2ablxmqiYVhzINUKe2WWzCSo4FuMHhm0uOFYJdsF9x8bVehFVVPkBkJOJlAVl9e
	 lNinBvDJreFsrWFQ8E8PXC981Vcc0CAWxWjjbbPp2/Rc1pWcq1iQeCfdy4SqFpHCN/VUh
	 XYxJzzOwI4LuAgIIWW56TGjV8g3lmMPWr18Pee6Dnlz6T8Q9N13zeyKuJaf4jN2m5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbAuKfh4;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3019606A325;
	Fri, 20 Nov 2026 17:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3019606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbAuKfh4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795197405; x=1826733405;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HT8MQLBizI6+BrsOYn2afQdMLw43mvUUopKTSq+YUas=;
  b=YbAuKfh431ExMF0DNTnRGMzDmZAE9gE5j9iASO+G9csxqZJA/0/62P/f
   qE0kZU9U/f35Yvjfi+f+C9tiU8eoInP2jolsoxg517MP3YHWRkDwT093H
   uHKPkvwUDHwhG8trIO568xztRRErZpQltR9PRe3vDxEucWQnUqZe/a9Wy
   56W3Aqn97e+W0ennpPERWP+w4sfqL4cQITRSN2W2rnT/Q1u0P2S67yASa
   9aYQ77JmkRVyrY9UsxsphBoDTwc/Hf3gnvg7GcUgFPnbtA/1Hzbw+PiAb
   WbF8bhhT4PaPs+21rhsjK9PzAU0TQ+gHcNbobtM1LlcHPtlnhmJwFYBwZ
   w==;
X-CSE-ConnectionGUID: 7CpRCeTvRZKpnyy570prSA==
X-CSE-MsgGUID: r8At2w7wR0CPdbLa2kkY1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4181601"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4181601"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:56:45 -0800
X-CSE-ConnectionGUID: b470BH+nQ4CLR1oDEGeJSQ==
X-CSE-MsgGUID: SEOfRnjwSDKqu1oRRQiBvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="12751681"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.9]) ([10.124.220.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:56:43 -0800
Message-ID: <b5895e5e678eaef85eca3d4e050f6c22f0ce3e6c.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Zheng Shuhao <viennaoffh@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Benjamin Tissoires	 <bentiss@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, 	linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ayaan Mirza Baig	
 <ayaanmirzabaig85@gmail.com>, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com, Zhang Lixu	
 <lixu.zhang@intel.com>
Date: Fri, 20 Nov 2026 09:56:41 -0800
In-Reply-To: <179519435494.24396.10633733692339086433@viennaoffh.gmail.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
	 <20261120135005.566-1-viennaoffh@gmail.com>
	 <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
	 <0165ee623890e4d3778390e46ad955956c512812.camel@linux.intel.com>
	 <179519435494.24396.10633733692339086433@viennaoffh.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-21 at 01:05 +0800, Zheng Shuhao wrote:
> =C2=A0> In reality this can't happen as the hid_hw_close() and
> hid_hw_stop()
> > is called before, so there can't be any raw_event.
>=20
> It might not be reachable after hid_hw_stop(). I may have
> misunderstood the
> lockdep report and overstated this as a possible deadlock. Sorry.
>=20
> > How come this is possible? The HID sensor hub is only deleting its
> > own
> > children. Can you give an example here?
>=20
> With CONFIG_HID_BATTERY_STRENGTH=3Dy, this UHID device creates a Sensor
> Hub and
> a Joystick battery. The HID input layer registers the battery power
> supply as
> a child of the HID device, without platform_data.
>=20
> With the unpatched hid-sensor-hub module, UHID_DESTROY triggers a
> KASAN
> NULL-pointer dereference in sensor_hub_finalize_pending_fn():
>=20
> =C2=A0 KASAN: null-ptr-deref in range [0x0000000000000028-
> 0x000000000000002f]
> =C2=A0 RIP: sensor_hub_finalize_pending_fn+0x44/0x65 [hid_sensor_hub]
> =C2=A0 Call trace: device_for_each_child -> sensor_hub_remove ->
> hid_device_remove
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 -> hid_destroy_device -> uhid_dev_destroy ->
> uhid_char_write
>=20

OK, Adding to commit description will help for others.

Thanks,
Srinivas

> The reproducer is below:
>=20
> #define _GNU_SOURCE
> #include <dirent.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <linux/input.h>
> #include <linux/uhid.h>
> #include <poll.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
>=20
> static const unsigned char sensor_battery_rdesc[] =3D {
> 	0x05, 0x20,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Sensors) =
*/
> 	0x09, 0x10,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Sensor Hub) */
> 	0xa1, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Collection (Applicati=
on) */
> 	0xc0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* End Collection */
> 	0x05, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Generic D=
esktop) */
> 	0x09, 0x04,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Joystick) */
> 	0xa1, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Collection (Applicati=
on) */
> 	0x05, 0x06,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Generic D=
evice Controls) */
> 	0x09, 0x20,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Battery Streng=
th) */
> 	0x15, 0x00,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Logical Minimum (0) *=
/
> 	0x25, 0x64,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Logical Maximum (100)=
 */
> 	0x75, 0x08,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report Size (8) */
> 	0x95, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report Count (1) */
> 	0x81, 0x02,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Input (Data, Variable=
, Absolute) */
> 	0xc0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* End Collection */
> };
>=20
> static int send_event(int fd, struct uhid_event *event)
> {
> 	ssize_t written =3D write(fd, event, sizeof(*event));
>=20
> 	if (written =3D=3D sizeof(*event))
> 		return 0;
> 	if (written < 0)
> 		perror("write /dev/uhid");
> 	else
> 		fprintf(stderr, "short UHID write: %zd\n", written);
> 	return -1;
> }
>=20
> static bool hid_battery_exists(void)
> {
> 	static const char prefix[] =3D "hid-0003:1234:5678.";
> 	DIR *dir =3D opendir("/sys/class/power_supply");
> 	struct dirent *entry;
> 	bool found =3D false;
>=20
> 	if (!dir)
> 		return false;
> 	while ((entry =3D readdir(dir))) {
> 		if (!strncmp(entry->d_name, prefix, sizeof(prefix) -
> 1)) {
> 			found =3D true;
> 			break;
> 		}
> 	}
> 	closedir(dir);
> 	return found;
> }
>=20
> int main(void)
> {
> 	struct uhid_event event =3D { 0 };
> 	struct pollfd pfd;
> 	int fd, attempt;
> 	bool started =3D false;
> 	bool battery_found =3D false;
>=20
> 	fd =3D open("/dev/uhid", O_RDWR | O_CLOEXEC);
> 	if (fd < 0) {
> 		perror("open /dev/uhid");
> 		return 1;
> 	}
>=20
> 	event.type =3D UHID_CREATE2;
> 	strcpy((char *)event.u.create2.name, "sensor-hub-battery-
> null-test");
> 	strcpy((char *)event.u.create2.phys, "hid-null-test");
> 	event.u.create2.rd_size =3D sizeof(sensor_battery_rdesc);
> 	event.u.create2.bus =3D BUS_USB;
> 	event.u.create2.vendor =3D 0x1234;
> 	event.u.create2.product =3D 0x5678;
> 	memcpy(event.u.create2.rd_data, sensor_battery_rdesc,
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sensor_battery_rdesc));
> 	if (send_event(fd, &event))
> 		goto out_close;
>=20
> 	pfd.fd =3D fd;
> 	pfd.events =3D POLLIN;
> 	if (poll(&pfd, 1, 5000) <=3D 0) {
> 		fprintf(stderr, "timed out waiting for
> UHID_START\n");
> 		goto out_destroy;
> 	}
> 	memset(&event, 0, sizeof(event));
> 	if (read(fd, &event, sizeof(event)) !=3D sizeof(event)) {
> 		perror("read UHID event");
> 		goto out_destroy;
> 	}
> 	started =3D event.type =3D=3D UHID_START;
> 	if (!started) {
> 		fprintf(stderr, "unexpected UHID event: %u\n",
> event.type);
> 		goto out_destroy;
> 	}
>=20
> 	for (attempt =3D 0; attempt < 50 && !hid_battery_exists();
> attempt++)
> 		usleep(100000);
> 	if (!hid_battery_exists()) {
> 		fprintf(stderr, "HID battery power-supply child was
> not created\n");
> 		goto out_destroy;
> 	}
> 	battery_found =3D true;
> 	puts("HID battery power-supply child created");
>=20
> out_destroy:
> 	memset(&event, 0, sizeof(event));
> 	event.type =3D UHID_DESTROY;
> 	if (send_event(fd, &event))
> 		goto out_close;
> 	usleep(300000);
> 	if (!started)
> 		goto out_close;
> 	puts("UHID device destroyed without userspace error");
> 	close(fd);
> 	return battery_found ? 0 : 1;
>=20
> out_close:
> 	close(fd);
> 	return 1;
> }
