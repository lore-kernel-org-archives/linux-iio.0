Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291360;
	b=oYEbrfhpQjOVb5P2J4SQjS0AgLqQ1sTm74NZqqhHH+gwVGsd0UBd2zt2UWmBJapGta6/
	 q1hgTTHXp8EU7b8eSRWvgQUPAP4KeytB808J5yA6liJ5lS5Bkzr2e4DT0IriouOT6H15Y
	 a2IyRFOPVl/SBhWrCcj46TnXk+ZohRLoTv+UpjKqpG9M/k1XN1G8jxykMbuMgjy5MJdTR
	 xlWp3anNBJxhtrcKp/GoJj6ivH9u97Tw1ZZP7Ge9iT4PsLWkcPyVJ2k2kUudYunWc9lmy
	 ub4a5A7g2q7EaHu05ciVhf98bsydqM0fsPacoK9MQprIJnPC5U9pnudhkBfAn36YdWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291360;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v+GBDz+AJqJoMYmA1boyjHu+VeQgZnf+K2i7cfmLoAc=;
	b=fYFpsOmlOqbOpLRiRZfmEkW5fWKq9gQrKHraIhLdTKNlvWrMglRw44qj43PZc6QZNZDN
	 CInBGv7K3O5ihZ3dFWMs2KtMaKvk8spsIoH+eepf++VmFECs6hPOe92aue9p6eGvH/rsu
	 afMx2vVYRj1Pwe9ZuThID5lYUSWwHcUG5FSnyAooaYlfdBXmlqfklkDbfjXZ91aBBJ4vV
	 sPY/LsnzwG0BEXvnbuILUAIBQjXpUGw8UMm5LhLXA4aaXZdcKuNjnWy/mzIaW+oa2bOUu
	 37sN0Myv7GJr5nrsyh5CoAwGPNHvRLqf9JnZQEOpqD/n7qj52g999vYzV5CQcA/mL9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GheR8TjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8197606A320;
	Sat, 21 Nov 2026 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GheR8TjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1371F000C4;
	Sat, 21 Nov 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795291359;
	bh=v+GBDz+AJqJoMYmA1boyjHu+VeQgZnf+K2i7cfmLoAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GheR8TjLPsIqz5loQwBATvfLhbgL9vZMMU82k6rB1DyFc3mhLdV4yQo/eHXn9Nw8F
	 YPQOM8cVhfasZXO3BerfjoWa0KKLLE3ED0hIKblhMZGLnJfsBHarIkpIQVStJ10oOQ
	 93D8mUAKw7pfE2PAP5Ofmb+5pm8tVXn7e8nX7C5ZOf56EoMdaEA6rcK596M5Xwj0eh
	 PTyV/j839+O6zLv8sDnbsRe0BcZ/b1fWsJTLWyrJSsvxl8OebO+nTawNAiLNvsFevu
	 aVJH/exjQrzT4q0/nxSNN5Pyni//xhvYmaUoLaUkC64Kv54h1oGNe7oMA0JYBwP7ra
	 /jzC+p889qkLg==
Date: Sat, 21 Nov 2026 20:02:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Zheng Shuhao <viennaoffh@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires	 <bentiss@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ayaan Mirza Baig	
 <ayaanmirzabaig85@gmail.com>,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com, Zhang Lixu	
 <lixu.zhang@intel.com>
Subject: Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child
 iteration
Message-ID: <20261121200230.6b1ccffd@jic23-hlaptop>
In-Reply-To: <b5895e5e678eaef85eca3d4e050f6c22f0ce3e6c.camel@linux.intel.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
	<20261120135005.566-1-viennaoffh@gmail.com>
	<573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
	<0165ee623890e4d3778390e46ad955956c512812.camel@linux.intel.com>
	<179519435494.24396.10633733692339086433@viennaoffh.gmail.com>
	<b5895e5e678eaef85eca3d4e050f6c22f0ce3e6c.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2026 09:56:41 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Sat, 2026-11-21 at 01:05 +0800, Zheng Shuhao wrote:
> > =C2=A0> In reality this can't happen as the hid_hw_close() and =20
> > hid_hw_stop() =20
> > > is called before, so there can't be any raw_event. =20
> >=20
> > It might not be reachable after hid_hw_stop(). I may have
> > misunderstood the
> > lockdep report and overstated this as a possible deadlock. Sorry.
> >  =20
> > > How come this is possible? The HID sensor hub is only deleting its
> > > own
> > > children. Can you give an example here? =20
> >=20
> > With CONFIG_HID_BATTERY_STRENGTH=3Dy, this UHID device creates a Sensor
> > Hub and
> > a Joystick battery. The HID input layer registers the battery power
> > supply as
> > a child of the HID device, without platform_data.
> >=20
> > With the unpatched hid-sensor-hub module, UHID_DESTROY triggers a
> > KASAN
> > NULL-pointer dereference in sensor_hub_finalize_pending_fn():
> >=20
> > =C2=A0 KASAN: null-ptr-deref in range [0x0000000000000028-
> > 0x000000000000002f]
> > =C2=A0 RIP: sensor_hub_finalize_pending_fn+0x44/0x65 [hid_sensor_hub]
> > =C2=A0 Call trace: device_for_each_child -> sensor_hub_remove ->
> > hid_device_remove
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -> hid_destroy_device -> uhid_dev_destroy ->
> > uhid_char_write
> >  =20
>=20
> OK, Adding to commit description will help for others.

Process thing.  Zhang Lixu, please do not send a new version
in reply to an older one.  I only spotted this today because
I was working for patchwork. Otherwise it would be way back
in my email history and probably lost.

New version, new email thread.  Avoids breaking tools and
keeps things in order for those reviewing patches.
It seems the LLMs are following the suggested process for the
git project itself.  As far as I aware no part of the kernel
has ever asked for this style of replying to an earlier commit
and many actively oppose it because it makes a massive mess
for large series.

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas
>=20
> > The reproducer is below:
> >=20
> > #define _GNU_SOURCE
> > #include <dirent.h>
> > #include <errno.h>
> > #include <fcntl.h>
> > #include <linux/input.h>
> > #include <linux/uhid.h>
> > #include <poll.h>
> > #include <stdbool.h>
> > #include <stdio.h>
> > #include <string.h>
> > #include <unistd.h>
> >=20
> > static const unsigned char sensor_battery_rdesc[] =3D {
> > 	0x05, 0x20,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Sensors=
) */
> > 	0x09, 0x10,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Sensor Hub) =
*/
> > 	0xa1, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Collection (Applica=
tion) */
> > 	0xc0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* End Collection */
> > 	0x05, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Generic=
 Desktop) */
> > 	0x09, 0x04,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Joystick) */
> > 	0xa1, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Collection (Applica=
tion) */
> > 	0x05, 0x06,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage Page (Generic=
 Device Controls) */
> > 	0x09, 0x20,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Usage (Battery Stre=
ngth) */
> > 	0x15, 0x00,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Logical Minimum (0)=
 */
> > 	0x25, 0x64,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Logical Maximum (10=
0) */
> > 	0x75, 0x08,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report Size (8) */
> > 	0x95, 0x01,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Report Count (1) */
> > 	0x81, 0x02,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Input (Data, Variab=
le, Absolute) */
> > 	0xc0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /* End Collection */
> > };
> >=20
> > static int send_event(int fd, struct uhid_event *event)
> > {
> > 	ssize_t written =3D write(fd, event, sizeof(*event));
> >=20
> > 	if (written =3D=3D sizeof(*event))
> > 		return 0;
> > 	if (written < 0)
> > 		perror("write /dev/uhid");
> > 	else
> > 		fprintf(stderr, "short UHID write: %zd\n", written);
> > 	return -1;
> > }
> >=20
> > static bool hid_battery_exists(void)
> > {
> > 	static const char prefix[] =3D "hid-0003:1234:5678.";
> > 	DIR *dir =3D opendir("/sys/class/power_supply");
> > 	struct dirent *entry;
> > 	bool found =3D false;
> >=20
> > 	if (!dir)
> > 		return false;
> > 	while ((entry =3D readdir(dir))) {
> > 		if (!strncmp(entry->d_name, prefix, sizeof(prefix) -
> > 1)) {
> > 			found =3D true;
> > 			break;
> > 		}
> > 	}
> > 	closedir(dir);
> > 	return found;
> > }
> >=20
> > int main(void)
> > {
> > 	struct uhid_event event =3D { 0 };
> > 	struct pollfd pfd;
> > 	int fd, attempt;
> > 	bool started =3D false;
> > 	bool battery_found =3D false;
> >=20
> > 	fd =3D open("/dev/uhid", O_RDWR | O_CLOEXEC);
> > 	if (fd < 0) {
> > 		perror("open /dev/uhid");
> > 		return 1;
> > 	}
> >=20
> > 	event.type =3D UHID_CREATE2;
> > 	strcpy((char *)event.u.create2.name, "sensor-hub-battery-
> > null-test");
> > 	strcpy((char *)event.u.create2.phys, "hid-null-test");
> > 	event.u.create2.rd_size =3D sizeof(sensor_battery_rdesc);
> > 	event.u.create2.bus =3D BUS_USB;
> > 	event.u.create2.vendor =3D 0x1234;
> > 	event.u.create2.product =3D 0x5678;
> > 	memcpy(event.u.create2.rd_data, sensor_battery_rdesc,
> > 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(sensor_battery_rdesc));
> > 	if (send_event(fd, &event))
> > 		goto out_close;
> >=20
> > 	pfd.fd =3D fd;
> > 	pfd.events =3D POLLIN;
> > 	if (poll(&pfd, 1, 5000) <=3D 0) {
> > 		fprintf(stderr, "timed out waiting for
> > UHID_START\n");
> > 		goto out_destroy;
> > 	}
> > 	memset(&event, 0, sizeof(event));
> > 	if (read(fd, &event, sizeof(event)) !=3D sizeof(event)) {
> > 		perror("read UHID event");
> > 		goto out_destroy;
> > 	}
> > 	started =3D event.type =3D=3D UHID_START;
> > 	if (!started) {
> > 		fprintf(stderr, "unexpected UHID event: %u\n",
> > event.type);
> > 		goto out_destroy;
> > 	}
> >=20
> > 	for (attempt =3D 0; attempt < 50 && !hid_battery_exists();
> > attempt++)
> > 		usleep(100000);
> > 	if (!hid_battery_exists()) {
> > 		fprintf(stderr, "HID battery power-supply child was
> > not created\n");
> > 		goto out_destroy;
> > 	}
> > 	battery_found =3D true;
> > 	puts("HID battery power-supply child created");
> >=20
> > out_destroy:
> > 	memset(&event, 0, sizeof(event));
> > 	event.type =3D UHID_DESTROY;
> > 	if (send_event(fd, &event))
> > 		goto out_close;
> > 	usleep(300000);
> > 	if (!started)
> > 		goto out_close;
> > 	puts("UHID device destroyed without userspace error");
> > 	close(fd);
> > 	return battery_found ? 0 : 1;
> >=20
> > out_close:
> > 	close(fd);
> > 	return 1;
> > } =20
>=20

