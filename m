Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194899;
	b=IqF56bjurr1cDOkYqRQxQjMOaAHN+AyN1aufRxQrnExFaGsWJpj6YyUQiQrvLRt1zroP
	 2CeLYWlkbVa6PkoxZwqAFOC4zae/CrogE91n7UC/xZd5A4YDYdFgBqOsKtSqQUMM/+5FD
	 G05F/jQP6s1yjau7RDKCFH6mBchoJk15YipB/OeaPHqbJgQLeBFEAqwq1ocbjIx1YQ4S9
	 Sfv+K0lpSxAimHJtZa6Y37OBezwz8iM2y4SlEC48NQ9bYED8yzTFQZqH2o4sq0fEzq/kd
	 zwshZhQ4CStA34QQ+jMY895N/q3am+JMp0j6McmPWvfn7XmSaT/y3zFE2oCeOr3OkkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194899;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=uSFncaokGA+ftB76Em9/lA6Qac26fTHzjO+Cdt7Pka0=;
	b=Bvz+azOxjuGoGiYMrgsUfRSAUNIdHDSeBznCPvxR3/XsRsm9t+OTRjYl6kZH5C9oZsKl
	 txW/ZRBmsF6FCeh0eiDj019MkDMrZowPLWf4bKNLczz8WVwiIAKK+EKCZabKWabMtbHC6
	 kaMmV78/2eRQ1M7xYs7CIz/vmWUP6RE1K9ZUWplwRlihrOBk87zjIsetx24cTCT7qxvFg
	 v3hSErWHNmmBFkOc2bEUlGc3IECu/00v+LPBr2PkV6NEQop0H9GM1lzXCMmiypgw3W+8t
	 9e+ippYkxlOEh/xc6U8Yp8chrI4HOUMAI6i4xX1loBn6f5eH6gkTbTqsbIMbBdQNW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpICBR9+;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3C60A2630
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 17:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DB3C60A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpICBR9+
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so656988b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795194898; x=1795799698; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uSFncaokGA+ftB76Em9/lA6Qac26fTHzjO+Cdt7Pka0=;
        b=YpICBR9+zI5srP1RRqUoioL9FL9gvT5zzQ5aQACKqfCv4O6iZUlGEOr1nSDtAf3aY6
         g/clZMxNmMPyAqVEyi4vbyxH72c0j24U2r3ZQGd0guJCMAWbw7wuXZJYS5nrrLC4SKxy
         caYboHGvEPQeXf0Kyw2LdrTEfeNt6/fEzayFhn0z8/unH7h/r8tUG1m00l9sb6lMlMC7
         lsbLghi0ZqXOA25PNpgtBv8QlIidmzovt1PiE2vxDeueUsPYyDm/BEhDL3lryMZs3uth
         5uYH9GW/AG7sNCPLzjCmXulneFV493Bz0nuLqisXyBtsJfZhaAb65ABQNBMdNbzQWVFF
         LdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194898; x=1795799698;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSFncaokGA+ftB76Em9/lA6Qac26fTHzjO+Cdt7Pka0=;
        b=eIX7SopabdjG62cXUuMAZUz4BLeLI31U2+wWnDtcpwquhgR5NSgzbifC0jr8PysIt+
         kQ9MdRCH15Unj0hUFcQjjjcVfpEwagX7CGA8zOZVRMFD+ZjAZNH/iyk206BKWtHZvvDC
         sPxYlYQ7hUeEZZ4L3rxdvoLmiervpczsrhrQ1VSTx4uTjuvZPHdIyhQ2Q4ZLnyWi1NxL
         SJQ3ZGo0y1tXb/xRlPUpkT7RZ1yVqBEjOzOoKXkidoUV8A2HRdTOHXtbULs1KOB2E2aU
         tcGRqNIaJhnRRiaVC1XWd3ByPJEzM3RjXUyLRcy/JIM0ebA2UsRP63i2xqV5g5xO87dZ
         hDoQ==
X-Forwarded-Encrypted: i=1; AL+hErE24YbsFirMzGCQh8UtwbvvDdlghQnagGEzPQLRvwoHTT3JBdpcCA7a7wosC3gjjLqDVvutbEjO2TY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cbqparFQv0ki7lp2lTh5qjkSdRTp8vAtpWUXviRVPs26p/mU1
	C64Guipzm1FrSxNVL947shaWo6ObDMO4KpxGjNZ4FvSASbogQAwzGD+ceoJ4yQ22
X-Gm-Gg: AYBFou1YP/CCyV1Us7OsLNCEwQcelp2IzOlZCavb0HdQh+WdZ/U7u+7RN7MgJxFFuTZ
	9gDKG/viHff8/kVA06j3uW8TNNWXLg/jZUFbOh+DjqlO0TJ0/ypLSbSKEHBhtefWPgOJWZeAEq+
	ZbwQU59/CgSUxptYAIfvkL3f6Jqk1474bpnGNH2Udn24TWOa41AGxGIb6bMRiLaGjn+qCldD2Un
	arpR0dtZb0sENuBLdVo/XuN+5zF89lEAP6ZxDILlHw2ybi3LClfMJVN0GCj9SS+mJMjvOxGNNYr
	aJnnG5gRWowuyvqDiVIWOVjt5esnkzavCS/5W8uBZpyrfCrrNFS9t5+xG5WQikthspcUtG1GE9M
	+jiuh0Q+vm8gyDipOTxTmLRjTPH+4a5KD2SZZ0cq5tK/1Oo1Bblw4KZ/jiH4gGbMEvW1WXLqDqh
	ea6ODtZOOqKPi2GTeawqxJWxtKswiRxm+PJoBo8BwP3pcabLKt2IyDyGJOb8LFLpZvsQfExIFSD
	zqYhnlkEE5PvAmOVjTqeMlizVglM9cISey7FW0D11u3YoJptCh9DyvgcTm30QoafL4UIwbYchgO
	MvR8gXod8NXRnOBn8hnMKIPdSnnpHjeUM0EkKuAWud3Ca0gQ79gHUw==
X-Received: by 2002:a05:6a00:b48:b0:886:5f48:3fca with SMTP id d2e1a72fcca58-8c87cb4c02amr3644014b3a.37.1795194898216;
        Fri, 20 Nov 2026 09:14:58 -0800 (PST)
Received: from DESKTOP-UCPRL76.localdomain ([113.200.174.114])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e457d1sm1718377b3a.30.2026.11.20.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:14:57 -0800 (PST)
From: Zheng Shuhao <viennaoffh@gmail.com>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com,
 Zhang Lixu <lixu.zhang@intel.com>
Subject:
 Re: [PATCH v2] HID: sensor-hub: Avoid holding spinlock across child iteration
Date: Sat, 21 Nov 2026 01:05:54 +0800
Message-ID: <179519435494.24396.10633733692339086433@viennaoffh.gmail.com>
In-Reply-To: <0165ee623890e4d3778390e46ad955956c512812.camel@linux.intel.com>
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
 <20261120135005.566-1-viennaoffh@gmail.com>
 <573f3eb75601c17d6e766fc47a7cce1bc2274998.camel@linux.intel.com>
 <0165ee623890e4d3778390e46ad955956c512812.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

 > In reality this can't happen as the hid_hw_close() and hid_hw_stop()
> is called before, so there can't be any raw_event.

It might not be reachable after hid_hw_stop(). I may have misunderstood the
lockdep report and overstated this as a possible deadlock. Sorry.

> How come this is possible? The HID sensor hub is only deleting its own
> children. Can you give an example here?

With CONFIG_HID_BATTERY_STRENGTH=y, this UHID device creates a Sensor Hub and
a Joystick battery. The HID input layer registers the battery power supply as
a child of the HID device, without platform_data.

With the unpatched hid-sensor-hub module, UHID_DESTROY triggers a KASAN
NULL-pointer dereference in sensor_hub_finalize_pending_fn():

  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  RIP: sensor_hub_finalize_pending_fn+0x44/0x65 [hid_sensor_hub]
  Call trace: device_for_each_child -> sensor_hub_remove -> hid_device_remove
              -> hid_destroy_device -> uhid_dev_destroy -> uhid_char_write

The reproducer is below:

#define _GNU_SOURCE
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/input.h>
#include <linux/uhid.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

static const unsigned char sensor_battery_rdesc[] = {
	0x05, 0x20,       /* Usage Page (Sensors) */
	0x09, 0x10,       /* Usage (Sensor Hub) */
	0xa1, 0x01,       /* Collection (Application) */
	0xc0,             /* End Collection */
	0x05, 0x01,       /* Usage Page (Generic Desktop) */
	0x09, 0x04,       /* Usage (Joystick) */
	0xa1, 0x01,       /* Collection (Application) */
	0x05, 0x06,       /* Usage Page (Generic Device Controls) */
	0x09, 0x20,       /* Usage (Battery Strength) */
	0x15, 0x00,       /* Logical Minimum (0) */
	0x25, 0x64,       /* Logical Maximum (100) */
	0x75, 0x08,       /* Report Size (8) */
	0x95, 0x01,       /* Report Count (1) */
	0x81, 0x02,       /* Input (Data, Variable, Absolute) */
	0xc0,             /* End Collection */
};

static int send_event(int fd, struct uhid_event *event)
{
	ssize_t written = write(fd, event, sizeof(*event));

	if (written == sizeof(*event))
		return 0;
	if (written < 0)
		perror("write /dev/uhid");
	else
		fprintf(stderr, "short UHID write: %zd\n", written);
	return -1;
}

static bool hid_battery_exists(void)
{
	static const char prefix[] = "hid-0003:1234:5678.";
	DIR *dir = opendir("/sys/class/power_supply");
	struct dirent *entry;
	bool found = false;

	if (!dir)
		return false;
	while ((entry = readdir(dir))) {
		if (!strncmp(entry->d_name, prefix, sizeof(prefix) - 1)) {
			found = true;
			break;
		}
	}
	closedir(dir);
	return found;
}

int main(void)
{
	struct uhid_event event = { 0 };
	struct pollfd pfd;
	int fd, attempt;
	bool started = false;
	bool battery_found = false;

	fd = open("/dev/uhid", O_RDWR | O_CLOEXEC);
	if (fd < 0) {
		perror("open /dev/uhid");
		return 1;
	}

	event.type = UHID_CREATE2;
	strcpy((char *)event.u.create2.name, "sensor-hub-battery-null-test");
	strcpy((char *)event.u.create2.phys, "hid-null-test");
	event.u.create2.rd_size = sizeof(sensor_battery_rdesc);
	event.u.create2.bus = BUS_USB;
	event.u.create2.vendor = 0x1234;
	event.u.create2.product = 0x5678;
	memcpy(event.u.create2.rd_data, sensor_battery_rdesc,
	       sizeof(sensor_battery_rdesc));
	if (send_event(fd, &event))
		goto out_close;

	pfd.fd = fd;
	pfd.events = POLLIN;
	if (poll(&pfd, 1, 5000) <= 0) {
		fprintf(stderr, "timed out waiting for UHID_START\n");
		goto out_destroy;
	}
	memset(&event, 0, sizeof(event));
	if (read(fd, &event, sizeof(event)) != sizeof(event)) {
		perror("read UHID event");
		goto out_destroy;
	}
	started = event.type == UHID_START;
	if (!started) {
		fprintf(stderr, "unexpected UHID event: %u\n", event.type);
		goto out_destroy;
	}

	for (attempt = 0; attempt < 50 && !hid_battery_exists(); attempt++)
		usleep(100000);
	if (!hid_battery_exists()) {
		fprintf(stderr, "HID battery power-supply child was not created\n");
		goto out_destroy;
	}
	battery_found = true;
	puts("HID battery power-supply child created");

out_destroy:
	memset(&event, 0, sizeof(event));
	event.type = UHID_DESTROY;
	if (send_event(fd, &event))
		goto out_close;
	usleep(300000);
	if (!started)
		goto out_close;
	puts("UHID device destroyed without userspace error");
	close(fd);
	return battery_found ? 0 : 1;

out_close:
	close(fd);
	return 1;
}
