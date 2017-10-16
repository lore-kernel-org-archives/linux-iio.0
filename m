Return-Path: <SRS0=dqrp=BP=jic23.retrosnub.co.uk=jic23@kernel.org>
Date: Mon, 16 Oct 2017 19:48:03 +0100
In-Reply-To: <1508167134-6243-5-git-send-email-bhumirks@gmail.com>
References: <1508167134-6243-1-git-send-email-bhumirks@gmail.com> <1508167134-6243-5-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 04/15] iio: make function argument and some structures const
To: Bhumika Goyal <bhumirks@gmail.com>,julia.lawall@lip6.fr,rjw@rjwysocki.net,lenb@kernel.org,alexander.shishkin@linux.intel.com,jic23@kernel.org,knaack.h@gmx.de,lars@metafoo.de,pmeerw@pmeerw.net,dledford@redhat.com,sean.hefty@intel.com,hal.rosenstock@gmail.com,hch@lst.de,sagi@grimberg.me,kishon@ti.com,bhelgaas@google.com,nab@linux-iscsi.org,balbi@kernel.org,gregkh@linuxfoundation.org,laurent.pinchart@ideasonboard.com,jlbec@evilplan.org,ccaulfie@redhat.com,teigland@redhat.com,mfasheh@versity.com,linux-acpi@vger.kernel.org,linux-kernel@vger.kernel.org,linux-iio@vger.kernel.org,linux-rdma@vger.kernel.org,netdev@vger.kernel.org,linux-nvme@lists.infradead.org,linux-pci@vger.kernel.org,linux-scsi@vger.kernel.org,target-devel@vger.kernel.org,linux-usb@vger.kernel.org,cluster-devel@redhat.com,ocfs2-devel@oss.oracle.com,linux-fsdevel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <7091CB3C-16A9-429D-B684-8141955611A7@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 16 October 2017 16:18:43 BST, Bhumika Goyal <bhumirks@gmail=2Ecom> wrot=
e:
>Make the argument of the functions iio_sw{d/t}_group_init_type_name
>const
>as they are only passed to the function config_group_init_type_name
>having
>the argument as const=2E
>
>Make the config_item_type structures const as they are either passed to
>the functions having the argument as const or they are
>stored in the const "ci_type" field of a config_item structure=2E
>
>Signed-off-by: Bhumika Goyal <bhumirks@gmail=2Ecom>
Acked-by: Jonathan Cameron <Jonathan=2ECameron@Huawei=2Ecom>
>---
>* Changes in v2- Combine all the followup patches and the
>constification
>patches into a series=2E
>
> drivers/iio/dummy/iio_simple_dummy=2Ec   | 2 +-
> drivers/iio/industrialio-configfs=2Ec    | 2 +-
> drivers/iio/industrialio-sw-device=2Ec   | 6 +++---
> drivers/iio/industrialio-sw-trigger=2Ec  | 6 +++---
> drivers/iio/trigger/iio-trig-hrtimer=2Ec | 2 +-
> drivers/iio/trigger/iio-trig-loop=2Ec    | 2 +-
> include/linux/iio/sw_device=2Eh          | 2 +-
> include/linux/iio/sw_trigger=2Eh         | 2 +-
> 8 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/iio/dummy/iio_simple_dummy=2Ec
>b/drivers/iio/dummy/iio_simple_dummy=2Ec
>index a45d01e=2E=2E6205247 100644
>--- a/drivers/iio/dummy/iio_simple_dummy=2Ec
>+++ b/drivers/iio/dummy/iio_simple_dummy=2Ec
>@@ -26,7 +26,7 @@
> #include <linux/iio/sw_device=2Eh>
> #include "iio_simple_dummy=2Eh"
>=20
>-static struct config_item_type iio_dummy_type =3D {
>+static const struct config_item_type iio_dummy_type =3D {
> 	=2Ect_owner =3D THIS_MODULE,
> };
>=20
>diff --git a/drivers/iio/industrialio-configfs=2Ec
>b/drivers/iio/industrialio-configfs=2Ec
>index 45ce2bc=2E=2E5a0aae1 100644
>--- a/drivers/iio/industrialio-configfs=2Ec
>+++ b/drivers/iio/industrialio-configfs=2Ec
>@@ -17,7 +17,7 @@
> #include <linux/iio/iio=2Eh>
> #include <linux/iio/configfs=2Eh>
>=20
>-static struct config_item_type iio_root_group_type =3D {
>+static const struct config_item_type iio_root_group_type =3D {
> 	=2Ect_owner       =3D THIS_MODULE,
> };
>=20
>diff --git a/drivers/iio/industrialio-sw-device=2Ec
>b/drivers/iio/industrialio-sw-device=2Ec
>index 81b49cf=2E=2E90df97c 100644
>--- a/drivers/iio/industrialio-sw-device=2Ec
>+++ b/drivers/iio/industrialio-sw-device=2Ec
>@@ -19,9 +19,9 @@
> #include <linux/configfs=2Eh>
>=20
> static struct config_group *iio_devices_group;
>-static struct config_item_type iio_device_type_group_type;
>+static const struct config_item_type iio_device_type_group_type;
>=20
>-static struct config_item_type iio_devices_group_type =3D {
>+static const struct config_item_type iio_devices_group_type =3D {
> 	=2Ect_owner =3D THIS_MODULE,
> };
>=20
>@@ -156,7 +156,7 @@ static void device_drop_group(struct config_group
>*group,
> 	=2Edrop_item	=3D &device_drop_group,
> };
>=20
>-static struct config_item_type iio_device_type_group_type =3D {
>+static const struct config_item_type iio_device_type_group_type =3D {
> 	=2Ect_group_ops =3D &device_ops,
> 	=2Ect_owner       =3D THIS_MODULE,
> };
>diff --git a/drivers/iio/industrialio-sw-trigger=2Ec
>b/drivers/iio/industrialio-sw-trigger=2Ec
>index 8d24fb1=2E=2Ebc6b7fb 100644
>--- a/drivers/iio/industrialio-sw-trigger=2Ec
>+++ b/drivers/iio/industrialio-sw-trigger=2Ec
>@@ -19,9 +19,9 @@
> #include <linux/configfs=2Eh>
>=20
> static struct config_group *iio_triggers_group;
>-static struct config_item_type iio_trigger_type_group_type;
>+static const struct config_item_type iio_trigger_type_group_type;
>=20
>-static struct config_item_type iio_triggers_group_type =3D {
>+static const struct config_item_type iio_triggers_group_type =3D {
> 	=2Ect_owner =3D THIS_MODULE,
> };
>=20
>@@ -156,7 +156,7 @@ static void trigger_drop_group(struct config_group
>*group,
> 	=2Edrop_item	=3D &trigger_drop_group,
> };
>=20
>-static struct config_item_type iio_trigger_type_group_type =3D {
>+static const struct config_item_type iio_trigger_type_group_type =3D {
> 	=2Ect_group_ops =3D &trigger_ops,
> 	=2Ect_owner       =3D THIS_MODULE,
> };
>diff --git a/drivers/iio/trigger/iio-trig-hrtimer=2Ec
>b/drivers/iio/trigger/iio-trig-hrtimer=2Ec
>index 3ee9216=2E=2E7accd01 100644
>--- a/drivers/iio/trigger/iio-trig-hrtimer=2Ec
>+++ b/drivers/iio/trigger/iio-trig-hrtimer=2Ec
>@@ -30,7 +30,7 @@ struct iio_hrtimer_info {
> 	ktime_t period;
> };
>=20
>-static struct config_item_type iio_hrtimer_type =3D {
>+static const struct config_item_type iio_hrtimer_type =3D {
> 	=2Ect_owner =3D THIS_MODULE,
> };
>=20
>diff --git a/drivers/iio/trigger/iio-trig-loop=2Ec
>b/drivers/iio/trigger/iio-trig-loop=2Ec
>index b4b02db=2E=2E94a90e0 100644
>--- a/drivers/iio/trigger/iio-trig-loop=2Ec
>+++ b/drivers/iio/trigger/iio-trig-loop=2Ec
>@@ -36,7 +36,7 @@ struct iio_loop_info {
> 	struct task_struct *task;
> };
>=20
>-static struct config_item_type iio_loop_type =3D {
>+static const struct config_item_type iio_loop_type =3D {
> 	=2Ect_owner =3D THIS_MODULE,
> };
>=20
>diff --git a/include/linux/iio/sw_device=2Eh
>b/include/linux/iio/sw_device=2Eh
>index fa79319=2E=2E8642b91 100644
>--- a/include/linux/iio/sw_device=2Eh
>+++ b/include/linux/iio/sw_device=2Eh
>@@ -60,7 +60,7 @@ struct iio_sw_device *to_iio_sw_device(struct
>config_item *item)
> static inline
> void iio_swd_group_init_type_name(struct iio_sw_device *d,
> 				  const char *name,
>-				  struct config_item_type *type)
>+				  const struct config_item_type *type)
> {
> #if IS_ENABLED(CONFIG_CONFIGFS_FS)
> 	config_group_init_type_name(&d->group, name, type);
>diff --git a/include/linux/iio/sw_trigger=2Eh
>b/include/linux/iio/sw_trigger=2Eh
>index c97eab6=2E=2E0c43738 100644
>--- a/include/linux/iio/sw_trigger=2Eh
>+++ b/include/linux/iio/sw_trigger=2Eh
>@@ -60,7 +60,7 @@ struct iio_sw_trigger *to_iio_sw_trigger(struct
>config_item *item)
> static inline
> void iio_swt_group_init_type_name(struct iio_sw_trigger *t,
> 				  const char *name,
>-				  struct config_item_type *type)
>+				  const struct config_item_type *type)
> {
> #if IS_ENABLED(CONFIG_CONFIGFS_FS)
> 	config_group_init_type_name(&t->group, name, type);

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
